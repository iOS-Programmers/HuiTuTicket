//
//  HTTaopiaoOrderDetalController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaopiaoOrderDetalController.h"
#import "TPOrderDetailHttp.h"


@interface HTTaopiaoOrderDetalController ()


@property (strong, nonatomic) TPOrderDetailHttp *orderHttp;


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

- (IBAction)onCancelOrderBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *onPayBtnClick;

@end

@implementation HTTaopiaoOrderDetalController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"订单详情";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView setContentSize:CGSizeMake(320, 400)];
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
        return;
    }
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTaopiaoOrderDetalController *weak_self = self;
    [self.orderHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.orderHttp.isValid) {
            

            
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



- (IBAction)onCancelOrderBtnClick:(id)sender {
}
@end
