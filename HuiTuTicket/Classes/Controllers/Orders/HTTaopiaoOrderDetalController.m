//
//  HTTaopiaoOrderDetalController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaopiaoOrderDetalController.h"
#import "TPOrderDetailHttp.h"
#import "TPOrderCancelHttp.h"

@interface HTTaopiaoOrderDetalController ()


@property (strong, nonatomic) TPOrderDetailHttp *orderHttp;
@property (strong, nonatomic) TPOrderCancelHttp *closeOrderHttp;


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *caseCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *buyTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiangjinLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderStatusLabel;

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *yudingNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel *scenicNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *traveltimeLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
- (IBAction)onCancelOrderBtnClick:(id)sender;
- (IBAction)onPayBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *payBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation HTTaopiaoOrderDetalController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"订单详情";
        _orderHttp = [[TPOrderDetailHttp alloc] init];
        _closeOrderHttp = [[TPOrderCancelHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView setContentSize:CGSizeMake(320, 400)];
    
    [self requestOrderData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestOrderData
{
    self.orderHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.orderHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    if (!FBIsEmpty(self.orderId)) {
        self.orderHttp.parameter.orderid = self.orderId;
    }
    else {
        [self showWithText:@"订单编号有误"];
        return;
    }
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTaopiaoOrderDetalController *weak_self = self;
    [self.orderHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.orderHttp.isValid) {
            
            [weak_self updateUIWithInfo:weak_self.orderHttp.resultModel];
            
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
/**
 *   景区门票订单：
 1、只有状态为已支付（待游玩）或已游玩时，即status=2或status=3时才能有二维码，其他状态不能有二维码。
 
 2、如果是网上支付类型的订单，状态status=1时，应该有“在线支付”按钮。
 3、已游玩和已取消状态的订单，或者其他状态下但预订的出游日期已过期时，不能有“取消订单”按钮。
 4、当状态status不等于1时，不能有“立即支付”按钮，即只有待支付状态（status=1）的订单，才需要有“在线支付”按钮。
 
 
 套票订单也同上，但套票产品都必须是网上支付，没有现场支付类型的。
 *
 */

- (void)updateUIWithInfo:(TPOrderDetail *)info
{
    self.caseCodeLabel.text = [NSString stringWithFormat:@"订单编号:  %@",info.orderId];
    self.buyTimeLabel.text = [NSString stringWithFormat:@"下单时间:  %@",info.addtime];
    self.orderPriceLabel.text = [NSString stringWithFormat:@"订单金额:  ￥%@",info.totalamount];
    self.jiangjinLabel.text = [NSString stringWithFormat:@"点评奖金:  ￥%@",info.jiangjin];

    if ([info.status isEqualToString:@"0"]) {
        self.orderStatusLabel.text = @"订单类型:  新订单";
        
        self.bottomView.hidden = NO;
    }
    //只有这种状态，才有在线支付按钮
    else if ([info.status isEqualToString:@"1"]) {
        self.orderStatusLabel.text = @"订单类型:  库存确认";
        self.bottomView.hidden = NO;
        self.cancelBtn.hidden = YES;
    }
    else if ([info.status isEqualToString:@"2"]) {
        self.orderStatusLabel.text = @"订单类型:  已支付(待游玩)";
        
        //隐藏掉底部的view
        self.bottomView.hidden = YES;
    }
    else if ([info.status isEqualToString:@"3"]) {
        self.orderStatusLabel.text = @"订单类型:  已游玩";
        
        //隐藏掉底部的view
        self.bottomView.hidden = YES;
    }
    
    self.productNameLabel.text = [NSString stringWithFormat:@"产品名称:  %@",info.title];
    self.yudingNumberLabel.text = [NSString stringWithFormat:@"预订数量:  %@",info.number];
    
    
    if ([info.scenicinfo count] > 0) {
        ScenicInfo *detail = (ScenicInfo *)info.scenicinfo[0];
        
        TaoPiaoTicket *ticket = (TaoPiaoTicket *)detail.ticket[0];
        
        self.scenicNameLabel.text = [NSString stringWithFormat:@"景点名称:  %@",detail.scenicName];
        self.ticketTypeLabel.text = [NSString stringWithFormat:@"票型:  %@  %@张",ticket.ticketName,ticket.num];
        self.traveltimeLabel.text = [NSString stringWithFormat:@"游玩日期:  %@",[LXUtils secondChangToDate:detail.traveltime]];
    }
    
    
}

/**
 *  取消订单
 */
- (IBAction)onCancelOrderBtnClick:(id)sender {
    self.closeOrderHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.closeOrderHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    if (!FBIsEmpty(self.orderId)) {
        self.closeOrderHttp.parameter.orderid = self.orderId;
    }
    else {
        [self showWithText:@"订单编号有误"];
        return;
    }
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTaopiaoOrderDetalController *weak_self = self;
    [self.closeOrderHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.closeOrderHttp.isValid) {
            
            [weak_self showWithText:@"订单取消成功!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weak_self.navigationController popViewControllerAnimated:YES];
            });
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.closeOrderHttp.erorMessage];
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
 *  立即支付
 */
- (IBAction)onPayBtnClick:(UIButton *)sender {
    LXLog(@"支付");
}



- (void)closeOrder
{
    
}
@end
