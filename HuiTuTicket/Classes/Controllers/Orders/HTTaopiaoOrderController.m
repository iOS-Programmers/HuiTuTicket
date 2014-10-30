//
//  HTTaopiaoOrderController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaopiaoOrderController.h"

#import "HTTaopiaoOrderDetalController.h"

#import "HTTaopiaoOrderCell.h"

#import "TPOrderListHttp.h"

@interface HTTaopiaoOrderController ()

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *lable;

@property (strong, nonatomic) TPOrderListHttp *orderHttp;

@end

@implementation HTTaopiaoOrderController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"套票订单";
        _orderHttp = [[TPOrderListHttp alloc] init];
        
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
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self requestOrderData];
}

#pragma mark - Action
- (void)requestOrderData
{
    self.orderHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.orderHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.orderHttp.parameter.page = @"1";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTaopiaoOrderController *weak_self = self;
    [self.orderHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.orderHttp.isValid) {
            
            weak_self.dataSource = weak_self.orderHttp.resultModel.info;
            
            if ([weak_self.dataSource count] == 0) {
                self.imageView.hidden = NO;
                self.lable.hidden = NO;
            }else
            {
                self.imageView.hidden = YES;
                self.lable.hidden = YES;
                self.tableView.hidden = NO;
            }
            
            [weak_self.tableView reloadData];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.orderHttp.erorMessage];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"scenicCell";
    //
    HTTaopiaoOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTaopiaoOrderCell" owner:self options:nil] lastObject];
    }
    
    
    TPOrder *tp = (TPOrder *)self.dataSource[indexPath.row];
    cell.scenicName.text = tp.title;
    cell.price.text = [NSString stringWithFormat:@"￥%@",tp.totalamount];
    cell.tourTime.text = [NSString stringWithFormat:@"出行日期：%@",tp.traveltime];
    cell.orderTime.text = [NSString stringWithFormat:@"下单日期：%@",tp.addtime];
    
    if ([tp.status isEqualToString:@"0"]) {
        cell.status.text = @"新订单";
    }
    else if ([tp.status isEqualToString:@"1"]) {
        cell.status.text = @"库存确认";
    }
    else if ([tp.status isEqualToString:@"2"]) {
        cell.status.text = @"已支付(待游玩)";
    }
    else if ([tp.status isEqualToString:@"3"]) {
        cell.status.text = @"已游玩";
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    TPOrder *model = self.dataSource[indexPath.row];
    HTTaopiaoOrderDetalController *vc = [[HTTaopiaoOrderDetalController alloc] initWithNibName:@"HTTaopiaoOrderDetalController" bundle:nil];
    vc.orderId = model.orderId;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
