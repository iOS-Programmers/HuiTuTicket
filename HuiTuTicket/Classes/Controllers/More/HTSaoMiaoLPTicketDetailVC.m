//
//  HTSaoMiaoLPTicketDetailVC.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTSaoMiaoLPTicketDetailVC.h"
#import "HTLPTicketDetailCell.h"
#import "LPTicketSearchHttp.h"
#import "HTTicketRegisterController.h"

#define Array  @[@"联票号码",@"产品名称",@"注册截止",@"有效期",@"使用截止",@"景区数量",@"合作单位",@"状态"]

@interface HTSaoMiaoLPTicketDetailVC ()
{
    UIImageView *ticketImage;
}
@property (strong, nonatomic)LPTicketSearchHttp *detailHttp;

- (IBAction)onTicketRegisterBtnClick:(id)sender;
@end

@implementation HTSaoMiaoLPTicketDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _detailHttp = [[LPTicketSearchHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    ticketImage = [[UIImageView alloc] init];
    ticketImage.frame = CGRectMake(0, 0, 320, 110);

    self.tableView.tableHeaderView = ticketImage;
    
    [self.tableView setFrame:CGRectMake(0, 0, 320, [HTFoundationCommon getScreenHeight] - 44 - 60)];
    
    [self requestLPTicketDataWithCodeNumber:self.ticketNumber];
}


- (void)requestLPTicketDataWithCodeNumber:(NSString *)codeNumber
{
    if (FBIsEmpty(self.ticketNumber)) {
        [self showErrorWithText:@"缺少联票号码"];
        return;
    }
    self.detailHttp.parameter.codenumber = self.ticketNumber;
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTSaoMiaoLPTicketDetailVC *weak_self = self;
    [self.detailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.detailHttp.isValid) {
            
            //获取成功后，更新界面
            [weak_self updateUIWithData:weak_self.detailHttp.resultModel];
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

/**
 *  更新界面
 *
 *  @param info 联票信息对象
 */

- (void)updateUIWithData:(LPTicketSearch *)info
{
    
    [ticketImage setImageWithURL:[NSURL URLWithString:info.picurl] placeholderImage:[UIImage imageNamed:@"mine_header_bg"]];
    
    if ([info.state isEqualToString:@"0"]) {
        info.state = @"未注册";
    }
    else if ([info.state isEqualToString:@"1"]) {
        info.state = @"已注册";
    }
    else {
        info.state = @"已过期";
    }
    
    NSMutableArray *dataArray = [[NSMutableArray alloc] initWithArray:@[info.codeNumber,info.lpName,info.reg_endtime,info.validitytime,info.use_endtime,info.scenic_num,info.company,info.state]];
    
    self.dataSource = dataArray;
    
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [Array count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

        HTLPTicketDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (cell == nil) {
            
            cell = [[[NSBundle mainBundle] loadNibNamed:@"HTLPTicketDetailCell" owner:self options:nil] lastObject];
        }
        cell.label.text = [Array objectAtIndex:indexPath.row];
    if ([self.dataSource count] > 0) {
        cell.label2.text = self.dataSource[indexPath.row];
    }
        return cell;
}


- (IBAction)onTicketRegisterBtnClick:(id)sender
{
    HTTicketRegisterController *registerVC = [[HTTicketRegisterController alloc] init];
    
    registerVC.lpCodeNumer = self.ticketNumber;
    
    [self.navigationController pushViewController:registerVC animated:YES];
}
@end
