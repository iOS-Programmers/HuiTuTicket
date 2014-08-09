//
//  HTLPTicketListController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLPTicketListController.h"
#import "HTTicketDetailController.h"
#import "HTLPTicketListCell.h"
#import "LPTicketListHttp.h"

@interface HTLPTicketListController ()

@property (strong, nonatomic) LPTicketListHttp *lplistHttp;

@end

@implementation HTLPTicketListController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"景区联票";
        _lplistHttp = [[LPTicketListHttp alloc] init];
    }
    return self;
}

#pragma mark - DataSource

- (void)loadDataSource
{

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.dataSource.count)
        [self loadDataSource];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 70;
    
    [self requestData];
}

- (void)requestData
{
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTLPTicketListController *weak_self = self;
    [self.lplistHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.lplistHttp.isValid) {
            
            weak_self.dataSource = weak_self.lplistHttp.resultModel.info;
            [weak_self.tableView reloadData];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.lplistHttp.erorMessage];
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
    static NSString *cellIdentifier = @"Cell";
    
    HTLPTicketListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTLPTicketListCell" owner:self options:nil] lastObject];
    }
    
    [cell configureWithData:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HTTicketDetailController *detail = [[HTTicketDetailController alloc] init];
    detail.ticket = (LPTicket *)self.dataSource[indexPath.row];
    [self.navigationController pushViewController:detail animated:YES];
   
}


@end
