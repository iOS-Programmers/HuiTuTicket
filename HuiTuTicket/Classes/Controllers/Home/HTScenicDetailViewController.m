//
//  HTScenicDetailViewController.m
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTScenicDetailViewController.h"
#import "HTScenicDetailViewCell.h"
#import "UIImageView+WebCache.h"
#import "HTOrderWriteViewController.h"
#import "HTOrderResultViewController.h"

#import "ScenicDetailHttp.h"
#import "ScenicTicketHttp.h"





@interface HTScenicDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UIImageView *headBgImageView;
@property (nonatomic, strong) IBOutlet UILabel *scenicNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@property (nonatomic,strong) ScenicDetailHttp *scenicDetailHttp;
@property (nonatomic,strong) ScenicTicketHttp *scenicTicketHttp;

@end

@implementation HTScenicDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.scenicDetailHttp = [[ScenicDetailHttp alloc] init];
        self.scenicTicketHttp = [[ScenicTicketHttp alloc] init];

        self.title = @"详情";
    }
    return self;
}

- (void)setScenicId:(NSString *)str
{
    _scenicId = [str copy];
    [self loadDataSource];
}

- (void)loadDataSource
{
    self.scenicDetailHttp.parameter.scenicid = self.scenicId;
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTScenicDetailViewController *weak_self = self;
    [self.scenicDetailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.scenicDetailHttp.isValid) {
            [weak_self loadProductData];
            [weak_self refreshUIShow];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.scenicDetailHttp.erorMessage];
        };
    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect]) {
            
            [weak_self showErrorWithText:kNETWORK_ERROR];
        }
        else {
            
            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
}

- (void)loadProductData
{
    self.scenicTicketHttp.parameter.scenicid = self.scenicId;
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTScenicDetailViewController *weak_self = self;
    [self.scenicTicketHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.scenicTicketHttp.isValid) {
            weak_self.dataSource =weak_self.scenicTicketHttp.resultModel.dataArray;
            [weak_self.tableView reloadData];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.scenicTicketHttp.erorMessage];
        };
    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect]) {
            
            [weak_self showErrorWithText:kNETWORK_ERROR];
        }
        else {
            
            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    CGRect frame = self.tableView.frame;
//    frame.size.height = self.view.frame.size.height - CGRectGetHeight(self.navigationController.navigationBar.bounds);
//    self.tableView.frame = frame;
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - custom
- (void)refreshUIShow
{
    [self.headBgImageView setImageWithURL:[NSURL URLWithString:self.scenicDetailHttp.resultModel.picture] placeholderImage:nil];
    self.scenicNameLabel.text = self.scenicDetailHttp.resultModel.scenicName;
    self.addressLabel.text = self.scenicDetailHttp.resultModel.address;
    self.descriptionLabel.text = self.scenicDetailHttp.resultModel.intro;
    self.priceLabel.text = self.scenicDetailHttp.resultModel.minprice;
    
    self.headBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headBgImageView.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    HTScenicDetailViewCell *cell = (HTScenicDetailViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTScenicDetailViewCell" owner:self options:nil] lastObject];
    }
    TicketModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.ticketNameLabel.text = model.ticketName;
    cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.bookprice];
    cell.oriPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    cell.returnMoneyLabel.text = [NSString stringWithFormat:@"¥%d",[model.price intValue]-[model.bookprice intValue]];
    cell.model = model;
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 117;
}
#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row%2 == 1) {
        HTOrderResultViewController *app = [[HTOrderResultViewController alloc] init];
        [self.navigationController pushViewController:app animated:YES];
        return;
    }
    TicketModel *model = [self.dataSource objectAtIndex:indexPath.row];
    HTOrderWriteViewController *app = [[HTOrderWriteViewController alloc] init];
    app.scenicId = self.scenicId;
    app.dataModel = model;
    [self.navigationController pushViewController:app animated:YES];
}



@end
