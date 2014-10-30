//
//  HTScenicOrderListViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTScenicOrderListViewController.h"
#import "HTScenicOrderListCell.h"
#import "TicketOrderQueryHttp.h"
#import "HTScenicOrderDetailVC.h"
@interface HTScenicOrderListViewController ()


@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *lable;

@property (strong, nonatomic) TicketOrderQueryHttp *ticketOrderHttp;

@end


@implementation HTScenicOrderListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"景区门票订单";
        _ticketOrderHttp = [[TicketOrderQueryHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lphome_03_big@2x"]];
    imageView.bounds = CGRectMake(0, 0, 96, 88);
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    imageView.hidden = YES;
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:(CGRect){{0,imageView.frame.origin.y + imageView.frame.size.height +5 },{320,20}}];
    lable.text = @"还没有订单，快来订票吧";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = [UIColor grayColor];
    lable.hidden = YES;
    [self.view addSubview:lable];
    self.lable = lable;
    
    self.tableView.rowHeight = 80;
    self.tableView.hidden = YES;
    
    [self requestOrderData];
    [self configuraTableViewNormalSeparatorInset];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)requestOrderData
{
    self.ticketOrderHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.ticketOrderHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.ticketOrderHttp.parameter.page = @"1";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTScenicOrderListViewController *weak_self = self;
    [self.ticketOrderHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.ticketOrderHttp.isValid) {
            
            weak_self.dataSource = weak_self.ticketOrderHttp.resultModel.info;
            
            if ([weak_self.dataSource count] == 0) {
                self.imageView.hidden = NO;
                self.lable.hidden = NO;
            }else
            {
                self.imageView.hidden = YES;
                self.lable.hidden = YES;
            }
            
            [weak_self.tableView reloadData];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.ticketOrderHttp.erorMessage];
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

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"scenicCell";
    //
    HTScenicOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTScenicOrderListCell" owner:self options:nil] lastObject];
    }
    
    [cell configureWithData:self.dataSource[indexPath.row]];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TicketOrderModel *model = self.dataSource[indexPath.row];
    HTScenicOrderDetailVC *vc = [[HTScenicOrderDetailVC alloc] initWithNibName:@"HTScenicOrderDetailVC" bundle:nil];
    vc.ticketOrderId = model.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
