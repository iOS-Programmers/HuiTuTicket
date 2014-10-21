//
//  HTTicketDetailController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTicketDetailController.h"
#import "HTAppointmentViewController.h"
#import "HTCYOrderViewController.h"

//生成二维码
#import "QRCodeGenerator.h"

#import "HTTicketDetailCell.h"
#import "MyTicketDetailInfoHttp.h"

#import "TicketUnbindHttp.h"

@interface HTTicketDetailController ()

@property (strong, nonatomic) MyTicketDetailInfoHttp *detailHttp;
@property (strong, nonatomic) TicketUnbindHttp *unbindHttp;

@property (strong, nonatomic) NSMutableArray *titles;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

//联票二维码以及联票号码
@property (weak, nonatomic) IBOutlet UIImageView *lpCodeImage;
@property (weak, nonatomic) IBOutlet UILabel *lpCodeLabel;


- (IBAction)segementChanged:(id)sender;
- (IBAction)onYuYueBtnClick:(id)sender;
- (IBAction)onYuYueRecordBtnClick:(id)sender;
- (IBAction)onUnbindBtnClick:(id)sender;

@end

@implementation HTTicketDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"联票详情";
        
        _detailHttp = [[MyTicketDetailInfoHttp alloc] init];
        _unbindHttp = [[TicketUnbindHttp alloc] init];
        
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView setContentSize:CGSizeMake(640, 500)];

    self.tableView.backgroundColor = kColorClear;
    self.tableView.backgroundView = nil;
    
    [self requestDetailData];
    
    self.titles = [self titleArray];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableArray *)titleArray
{
    NSMutableArray *titileArray = [[NSMutableArray alloc] initWithCapacity:0];
    [titileArray addObject:@[@"联票号码",@"注册人",@"证件号码",@"有效期至",@"注册时间"]];
    [titileArray addObject:@[@"产品名称",@"景区数量"]];
    
    return titileArray;
}

#pragma mark - Aciton

- (void)requestDetailData
{
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketDetailController *weak_self = self;
    
    if (!FBIsEmpty(self.ticket)) {
        self.detailHttp.parameter.codenumber = self.ticket.lpcode;
        self.detailHttp.parameter.username = self.ticket.lpuser;
    }
    
    [self.detailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.detailHttp.isValid) {

            [weak_self reloadTableviewData:weak_self.detailHttp.resultModel];

            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.detailHttp.erorMessage];
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

- (void)reloadTableviewData:(MyTicketDetailInfo *)detail
{
    //更新界面
    self.lpCodeLabel.text = detail.codeNumber;
    
    //生成二维码
    if (!FBIsEmpty(detail.codeNumber)) {
        self.lpCodeImage.image = [QRCodeGenerator qrImageForString:detail.codeNumber imageSize:self.lpCodeImage.bounds.size.width];
    }
    
    
    LXLog(@"\n\n\n\n\n\\n\n\n\n\\n\n\n    %@",detail);
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    [dataArray addObject:@[detail.codeNumber,detail.username,detail.idcard,detail.endtime,detail.regtime]];
    [dataArray addObject:@[detail.lpName,detail.scenic_num]];
    
    self.dataSource = dataArray;
    
    [self.tableView reloadData];
}

/**
 *  联票解除绑定接口
 *
 *  @param bid 绑定记录id
 */
- (void)requestUnbind:(NSString *)bid
{
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketDetailController *weak_self = self;
    
    self.unbindHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.unbindHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.unbindHttp.parameter.bid = bid;
    
    [self.unbindHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.unbindHttp.isValid) {

            [weak_self showWithText:@"解除绑定成功"];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.unbindHttp.erorMessage];
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


- (IBAction)segementChanged:(id)sender
{
    UISegmentedControl *segement = (UISegmentedControl *)sender;

    switch (segement.selectedSegmentIndex) {
        case 0:
        {
            //联票详情
            [self.scrollView setContentOffset:CGPointMake(0, 0)];
        }
            break;
        case 1:
        {
            //二维码
            [self.scrollView setContentOffset:CGPointMake(320, 0)];
        }
            break;
            
        default:
            break;
    }
}

/**
 *  我要预约
 *
 *  @param sender
 */
- (IBAction)onYuYueBtnClick:(id)sender
{
    HTCYOrderViewController *yuyue = [[HTCYOrderViewController alloc] init];
    
    if (self.detailHttp.resultModel) {
        yuyue.ticketdetail = (MyTicketDetailInfo *)self.detailHttp.resultModel;
    }
    
    [self.navigationController pushViewController:yuyue animated:YES];
}

/**
 *  预约记录
 *
 *  @param sender
 */
- (IBAction)onYuYueRecordBtnClick:(id)sender
{
    HTAppointmentViewController *app = [[HTAppointmentViewController alloc] init];
    [self.navigationController pushViewController:app animated:YES];
}

/**
 *  解除绑定
 *
 *  @param sender
 */
- (IBAction)onUnbindBtnClick:(id)sender
{
    [self requestUnbind:self.ticket.lpcode];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.titles count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"detailCell";
//
    HTTicketDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTicketDetailCell" owner:self options:nil] lastObject];
    }
    
    NSArray *titleArr = self.titles[indexPath.section];
    cell.titleLabel.text = titleArr[indexPath.row];
    
   
    if ([self.dataSource count] != 0) {
         NSArray *detailArr = self.dataSource[indexPath.section];
        cell.detailLabel.text = detailArr[indexPath.row];
    }

    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
