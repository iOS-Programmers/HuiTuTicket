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

@interface HTScenicDetailViewController ()

@property (nonatomic, strong) IBOutlet UIView *headView;
@property (nonatomic, strong) IBOutlet UIImageView *headBgImageView;
@property (nonatomic, strong) IBOutlet UILabel *scenicNameLabel;
@property (nonatomic, strong) IBOutlet UILabel *evaluateLabel;
@property (nonatomic, strong) IBOutlet UILabel *addressLabel;
@property (nonatomic, strong) IBOutlet UILabel *descriptionLabel;

@property (nonatomic,strong) ScenicDetailHttp *scenicDetailHttp;
@end

@implementation HTScenicDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.scenicDetailHttp = [[ScenicDetailHttp alloc] init];
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
    self.dataSource = [NSMutableArray arrayWithArray:@[@"1",@"2",@"1",@"1",@"1"]];
    self.scenicDetailHttp.parameter.scenicid = @"11";
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTScenicDetailViewController *weak_self = self;
    [self.scenicDetailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.scenicDetailHttp.isValid) {
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGRect frame = self.tableView.frame;
//    frame.size.height = self.view.frame.size.height - CGRectGetHeight(self.navigationController.navigationBar.bounds);
    self.tableView.frame = frame;
    
    [self loadDataSource];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom
- (void)refreshUIShow
{
    [self.headBgImageView setImageWithURL:[NSURL URLWithString:@"http://pic.nipic.com/2008-07-15/200871513185159_2.jpg"] placeholderImage:nil];
    self.scenicNameLabel.text = @"景区名称";
    self.evaluateLabel.text = @"108好汉评价过";
    self.addressLabel.text = @"河南省郑大工学院";
    self.descriptionLabel.text = @"河南省郑大工学院河南省郑大工学院河南省郑大工学院";
    
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
    HTOrderWriteViewController *app = [[HTOrderWriteViewController alloc] init];
    [self.navigationController pushViewController:app animated:YES];
}

@end
