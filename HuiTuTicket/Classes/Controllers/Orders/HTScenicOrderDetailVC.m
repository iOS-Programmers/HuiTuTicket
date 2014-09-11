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

@property (strong, nonatomic) TicketOrderDetailHttp *ticketOrderDetailHttp;

- (IBAction)cancelOrderAction:(id)sender;

- (IBAction)goonAction:(id)sender;


@end

@implementation HTScenicOrderDetailVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _ticketOrderDetailHttp = [[TicketOrderDetailHttp alloc] init];
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

- (void)loadData
{
    self.ticketTypeLabel.text = self.ticketOrderDetailHttp.resultModel.ticketName;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.ticketOrderDetailHttp.resultModel.totalamount];
    self.orderNumLabel.text = self.ticketOrderDetailHttp.resultModel.orderId;
    self.travelDateLabel.text = self.ticketOrderDetailHttp.resultModel.traveltime;
    self.sceneNameLabel.text = self.ticketOrderDetailHttp.resultModel.scenicName;
    self.addressLabel.text = self.ticketOrderDetailHttp.resultModel.address;
    self.sceneAvaTimeLabel.text = self.ticketOrderDetailHttp.resultModel.opentime;
    self.payModeLabel.text = self.ticketOrderDetailHttp.resultModel.paymode;
    self.orderPhoneLabel.text = [NSString stringWithFormat:@"%@/%@",self.ticketOrderDetailHttp.resultModel.receivername,self.ticketOrderDetailHttp.resultModel.receivermoblie];
    //生成二维码
    if (!FBIsEmpty(self.ticketOrderDetailHttp.resultModel.ticketId))
    {
        self.erweimaIV.image = [QRCodeGenerator qrImageForString:self.ticketOrderDetailHttp.resultModel.ticketId imageSize:self.erweimaIV.bounds.size.width];
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
- (IBAction)cancelOrderAction:(id)sender {
}

- (IBAction)goonAction:(id)sender {
}
@end
