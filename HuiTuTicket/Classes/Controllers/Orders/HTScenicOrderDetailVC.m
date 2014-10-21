//
//  HTScenicOrderDetailVC.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-12.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTScenicOrderDetailVC.h"
#import "TicketOrderDetailHttp.h"
#import "QRCodeGenerator.h"
#import "HTEntranceTicketController.h"

#import "TicketOrderCancelHttp.h"

@interface HTScenicOrderDetailVC ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *ticketTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *erweimaIV;
@property (weak, nonatomic) IBOutlet UILabel *sceneNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *sceneAvaTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *payModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPhoneLabel;

@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *cancelOrderBtn;
@property (strong, nonatomic) TicketOrderDetailHttp *ticketOrderDetailHttp;

@property (strong, nonatomic) TicketOrderCancelHttp *cancelHttp;

- (IBAction)cancelOrderAction:(id)sender;

- (IBAction)goonAction:(id)sender;


@end

@implementation HTScenicOrderDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ticketOrderDetailHttp = [[TicketOrderDetailHttp alloc] init];
        _cancelHttp = [[TicketOrderCancelHttp alloc] init];
        self.title = @"详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.scrollView setContentSize:CGSizeMake(320, 590)];
    [self requestOrderData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *   景区门票订单：
 1、只有状态为已支付（待游玩）或已游玩时，即status=2或status=3时才能有二维码，其他状态不能有二维码。
 
 2、如果是网上支付类型的订单，状态status=1时，应该有“在线支付”按钮。
 3、已游玩和已取消状态的订单，或者其他状态下但预订的出游日期已过期时，不能有“取消订单”按钮。
 4、当状态status不等于1时，不能有“立即支付”按钮，即只有待支付状态（status=1）的订单，才需要有“在线支付”按钮。
 *
 */
- (void)loadData
{
    self.ticketTypeLabel.text = self.ticketOrderDetailHttp.resultModel.ticketName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.ticketOrderDetailHttp.resultModel.totalamount];
    self.orderNumLabel.text = [NSString  stringWithFormat:@"订单确认号:  %@",self.ticketOrderDetailHttp.resultModel.orderId];
    self.travelDateLabel.text = [NSString  stringWithFormat:@"入园日期:  %@",self.ticketOrderDetailHttp.resultModel.traveltime];
    self.sceneNameLabel.text = self.ticketOrderDetailHttp.resultModel.scenicName;
    self.addressLabel.text = self.ticketOrderDetailHttp.resultModel.address;
    self.sceneAvaTimeLabel.text = self.ticketOrderDetailHttp.resultModel.opentime;
    self.payModeLabel.text = [self.ticketOrderDetailHttp.resultModel.paymode isEqualToString:@"0"] ? @"现场支付" : @"网上支付";
    self.orderPhoneLabel.text = [NSString stringWithFormat:@"%@/%@",self.ticketOrderDetailHttp.resultModel.receivername,self.ticketOrderDetailHttp.resultModel.receivermoblie];
    //生成二维码
    if (!FBIsEmpty(self.ticketOrderDetailHttp.resultModel.ticketId))
    {
        if ([self.ticketOrderDetailHttp.resultModel.status isEqualToString:@"2"] || [self.ticketOrderDetailHttp.resultModel.status isEqualToString:@"3"]) {
            self.erweimaIV.image = [QRCodeGenerator qrImageForString:self.ticketOrderDetailHttp.resultModel.ticketId imageSize:self.erweimaIV.bounds.size.width];
        }
        else {
            self.erweimaIV.hidden = YES;
        }
    }
    
    //只有status为1时候，才有取消订单按钮
    if ([self.ticketOrderDetailHttp.resultModel.status isEqualToString:@"1"]) {
        self.cancelOrderBtn.hidden = NO;
    }
    else {
        self.cancelOrderBtn.hidden = YES;
    }

}

#pragma mark - Action
- (void)requestOrderData
{
    self.ticketOrderDetailHttp.parameter.orderid = self.ticketOrderId;
    self.ticketOrderDetailHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.ticketOrderDetailHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];;

    [self showLoadingWithText:kLOADING_TEXT];
    __weak HTScenicOrderDetailVC *weak_self = self;
    [self.ticketOrderDetailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.ticketOrderDetailHttp.isValid) {

            [weak_self loadData];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.ticketOrderDetailHttp.erorMessage];
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

#pragma mark -
#pragma mark - Action
- (IBAction)cancelOrderAction:(id)sender
{
    self.cancelHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.cancelHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    if (!FBIsEmpty(self.ticketOrderDetailHttp.parameter.orderid)) {
        self.cancelHttp.parameter.orderid = self.ticketOrderDetailHttp.parameter.orderid;
    }
    else {
        [self showWithText:@"订单编号有误"];
        return;
    }
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTScenicOrderDetailVC *weak_self = self;
    [self.cancelHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.cancelHttp.isValid) {
            
            [weak_self showWithText:@"订单取消成功!"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weak_self.navigationController popViewControllerAnimated:YES];
            });
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showWithText:@"订单取消失败!"];
//            [weak_self showErrorWithText:weak_self.cancelHttp.erorMessage];
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

- (IBAction)goonAction:(id)sender
{
    HTEntranceTicketController *vc = [[HTEntranceTicketController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];

}
@end
