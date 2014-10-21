//
//  HTAppointmentViewController.m
//  HuiTuTicket
//
//  Created by viewalloc on 14-8-3.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTAppointmentViewController.h"
#import "TicketOrderListHttp.h"
#import "HTAppointmentCell.h"

#import "HTYuYueDetailViewController.h"

@interface HTAppointmentViewController ()

@property (strong, nonatomic) TicketOrderListHttp *orderListHttp;

@end

@implementation HTAppointmentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"预约记录";
        _orderListHttp = [[TicketOrderListHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    self.tableView.rowHeight = 80;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestOrderListData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)requestOrderListData
{
    
    self.orderListHttp.parameter.codenumber = @"";
    self.orderListHttp.parameter.username = @"";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTAppointmentViewController *weak_self = self;
    [self.orderListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.orderListHttp.isValid) {

            [weak_self reloadTableViewData:weak_self.orderListHttp.resultModel];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.orderListHttp.erorMessage];
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

- (void)reloadTableViewData:(TicketOrderList *)listInfo
{
    if ([listInfo.info count] > 0) {
        self.dataSource = listInfo.info;
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    HTAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTAppointmentCell" owner:self options:nil];
        for (id oneObject in cellNib)
        {
            if ([oneObject isKindOfClass:[HTAppointmentCell class]])
            {
                cell = (HTAppointmentCell *)oneObject;
            }
        }
    }
    
    [cell configueUIWithData:(LPTicketOrderDetail *)self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
   LPTicketOrderDetail *detailInfo = (LPTicketOrderDetail *)self.dataSource[indexPath.row];
    
    HTYuYueDetailViewController *detail = [[HTYuYueDetailViewController alloc] init];
    detail.yuyueinfo = detailInfo;
    
    [self.navigationController pushViewController:detail animated:YES];
}

@end
