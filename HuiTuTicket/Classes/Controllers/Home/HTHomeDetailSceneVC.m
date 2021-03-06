//
//  HTHomeDetailSceneVC.m
//  HuiTuTicket
//
//  Created by Bird on 14/10/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeDetailSceneVC.h"
#import "HTHomeDetailSceneCell.h"
#import "UIImageView+WebCache.h"
#import "HTHomeDetailSceneDesVC.h"

#import "HTOrderWriteViewController.h"

#import "ScenicDetailHttp.h"

#import "ScenicTicketHttp.h"
#import "HTPayTableViewCell.h"

@interface HTHomeDetailSceneVC ()

@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UIImageView *headBgImageView;
@property (nonatomic, strong) IBOutlet UILabel *scenicNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@property (nonatomic, strong) UILabel *lable;

@property (nonatomic,strong) ScenicDetailHttp *scenicDetailHttp;
@property (nonatomic,strong) ScenicTicketHttp *scenicTicketHttp;
@end
@implementation HTHomeDetailSceneVC

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
    __block HTHomeDetailSceneVC *weak_self = self;
    [self.scenicDetailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.scenicDetailHttp.isValid) {
            [weak_self.tableView reloadData];
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
            
            [weak_self.lable setHidden:NO];
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
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleHeight;
    
    UILabel *lable = [[UILabel alloc] init];
    lable.bounds = CGRectMake(0,0, 320, 20);
    lable.center = CGPointMake(self.view.center.x, self.view.center.y-100);
    lable.text = @"网络不给力，请检查一下您的网络";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    lable.hidden = YES;
    [self.view addSubview:lable];
    self.lable = lable;
    
    self.tableView.hidden = YES;

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
    self.addressLabel.text = self.scenicDetailHttp.resultModel.city;
    
    self.headBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.headBgImageView.clipsToBounds = YES;
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
    
    self.tableView.hidden = NO;
}

/**
 *  请求景区门票产品接口
 */
- (void)loadProductData
{
    self.scenicTicketHttp.parameter.scenicid = self.scenicId;
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTHomeDetailSceneVC *weak_self = self;
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
            
            //[weak_self showErrorWithText:kNETWORK_ERROR];
            weak_self.lable.hidden = NO;
        }
        else {
            
            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    if (indexPath.section==0)
    {
        HTPayTableViewCell *cell = (HTPayTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HTPayTableViewCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.ticketNameLabel.text = @"成人票";
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.scenicDetailHttp.resultModel.minprice];
        [cell.zhankaiBtn addTarget:self action:@selector(openOrderView:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
    else
    {
        HTHomeDetailSceneCell *cell = (HTHomeDetailSceneCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HTHomeDetailSceneCell" owner:self options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        switch (indexPath.section)
        {
            case 1:
            {
                cell.upLabel.text = @"预定说明";
                cell.titleImg.image = [UIImage imageNamed:@"my_05"];
                
                
                cell.downLabel.text = [NSString stringWithFormat:@"预定限制：%@\n开放时间：%@\n入园方式：%@\n取票方式：%@",self.scenicDetailHttp.resultModel.orderlimit,self.scenicDetailHttp.resultModel.opentime,self.scenicDetailHttp.resultModel.pingzheng,self.scenicDetailHttp.resultModel.qupiao];
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"详细说明";
                cell.sepLineIV.hidden = YES;
                cell.titleImg.hidden = YES;
                cell.textLabel.font = [UIFont systemFontOfSize:15];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 3:
            {
                cell.upLabel.text = @"美食";
                cell.titleImg.image = [UIImage imageNamed:@"order_01"];
                
                
                cell.downLabel.text = self.scenicDetailHttp.resultModel.meishi;
            }
                break;
            case 4:
            {
                cell.upLabel.text = @"交通路线";
                cell.titleImg.image = [UIImage imageNamed:@"my_01"];
                cell.downLabel.text = self.scenicDetailHttp.resultModel.jiaotong;
            }
                break;
            case 5:
            {
                cell.upLabel.text = @"购物";
                cell.titleImg.image = [UIImage imageNamed:@"my_04"];
                
                
                cell.downLabel.text = self.scenicDetailHttp.resultModel.gouwu;
            }
                break;
                
            default:
                break;
        }
        
        CGRect cellFrame = [cell frame];
        cellFrame.origin = CGPointMake(0, 0);
        [cell.downLabel sizeToFit];
        if (cell.downLabel.frame.size.height > 44) {
            cellFrame.size.height = 90 + cell.downLabel.frame.size.height - 17;
        }
        else {
            cellFrame.size.height = 44;
        }
        [cell setFrame:cellFrame];
        return cell;
    }
}

- (void)openOrderView:(id)sender
{
    self.isOpen = !self.isOpen;
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section==0&&self.isOpen)
    {
        return self.orderView.frame.size.height;
    }
    else
    {
        return 1;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [LXUtils GetScreeWidth], 10)];
    view.backgroundColor = kHomeBGColor;
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section==0&&self.isOpen)
    {
        self.price.text = [NSString stringWithFormat:@"¥%@",self.scenicDetailHttp.resultModel.minprice];
        self.oriPriceLabel.text = [NSString stringWithFormat:@"¥%@",self.scenicDetailHttp.resultModel.price];
        
        
        return self.orderView;
    }
    else
    {
        UIView *view = [[UIView alloc] initWithFrame:CGRectNull];
        return view;
    }
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2)
    {
        HTHomeDetailSceneDesVC *vc = [[HTHomeDetailSceneDesVC alloc] initWithNibName:@"HTHomeDetailSceneDesVC" bundle:Nil];
        vc.scenicId = self.scenicId;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)orderAction:(id)sender
{
    HTOrderWriteViewController *app = [[HTOrderWriteViewController alloc] init];
    app.scenicId = self.scenicId;
    app.ticketDetail = self.scenicDetailHttp.resultModel;
    if ([self.dataSource count] > 0) {
        app.model = self.dataSource[0];
    }

    [self.navigationController pushViewController:app animated:YES];
}
@end
