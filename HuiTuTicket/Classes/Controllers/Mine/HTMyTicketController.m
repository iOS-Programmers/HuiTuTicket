//
//  HTMyTicketController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMyTicketController.h"
#import "HTMyTicketCell.h"
#import "MyTicketHttp.h"
#import "HTTicketDetailController.h"

@interface HTMyTicketController ()

@property (strong, nonatomic) MyTicketHttp *myticketHttp;
@end

@implementation HTMyTicketController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"我的联票";
        _myticketHttp = [[MyTicketHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 80;
    
//    self.dataSource = [NSMutableArray arrayWithArray:@[@"1",@"2",@"1",@"2",@"1",@"2"]];
    
    [self requestData];
}

- (void)requestData
{
    
    self.myticketHttp.parameter.uid = @"2";
    self.myticketHttp.parameter.session_key = @"bddfca43bf0b5955c76737e34fab386e";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTMyTicketController *weak_self = self;
    [self.myticketHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.myticketHttp.isValid) {
            [weak_self showWithText:@"获取我的联票列表成功"];
            weak_self.dataSource = weak_self.myticketHttp.resultModel.info;
            
            [weak_self.tableView reloadData];

        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.myticketHttp.erorMessage];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"myticketCell";
    
    HTMyTicketCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTMyTicketCell" owner:self options:nil] lastObject];
    }
    
    [cell configureWithData:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self pushViewController:@"HTTicketDetailController"];
}

@end
