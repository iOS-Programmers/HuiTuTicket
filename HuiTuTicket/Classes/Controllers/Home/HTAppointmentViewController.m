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
    
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@"1",@"2"]];
    self.tableView.rowHeight = 80;
}


- (void)requestOrderListData
{
    
    self.orderListHttp.parameter.codenumber = @"2";
//    self.orderListHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
//    self.orderListHttp.parameter.page = @"1";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTAppointmentViewController *weak_self = self;
    [self.orderListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.orderListHttp.isValid) {
            [weak_self showWithText:@"获取我的联票列表成功"];
//            weak_self.dataSource = weak_self.myticketHttp.resultModel.info;
//            
//            [weak_self.tableView reloadData];
            
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
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
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
