//
//  HTOrderResultViewController.m
//  HuiTuTicket
//
//  Created by on 14-8-8.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTOrderResultViewController.h"
#import "HTHomeTableViewCell.h"

#import "HTMPOrderInfoHttp.h"

//AlixPay
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"

@interface HTOrderResultViewController ()

@property (weak, nonatomic) IBOutlet UILabel *productNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *travelTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ticketNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderPriceLabel;

@property (nonatomic,strong) HTMPOrderInfoHttp *hTMPOrderInfoHttp;

- (IBAction)onClientPayBtnClick:(UIButton *)sender;
- (IBAction)onWebPayBtnClick:(UIButton *)sender;

@end

@implementation HTOrderResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"支付方式";
        
        self.hTMPOrderInfoHttp = [[HTMPOrderInfoHttp alloc] init];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPayFinish:)
                                                 name:ALIPAY_DONE
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALIPAY_DONE object:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self refreshUIShow];
    
    /**
     *  请求订单信息
     */
    [self getOrderInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom
- (void)refreshUIShow
{
    
    if (!FBIsEmpty(self.produtName)) {
        self.productNameLabel.text = self.produtName;
    }
    
    if (!FBIsEmpty(self.traveDate)) {
        self.travelTimeLabel.text = self.traveDate;
    }
    
    if (!FBIsEmpty(self.number)) {
        self.ticketNumLabel.text = [NSString stringWithFormat:@"%@张",self.number];
    }
    
    if (!FBIsEmpty(self.totalMoney)) {
        self.orderPriceLabel.text = [NSString stringWithFormat:@"￥%@",self.totalMoney];
    }
}


#pragma mark - Action
/**
 *  支付宝客户端支付
 *
 */
- (IBAction)onClientPayBtnClick:(UIButton *)sender
{
    [self createOrderAndSignToAliPay];

}

/**
 *  支付宝网页支付
 *
 */
- (IBAction)onWebPayBtnClick:(UIButton *)sender
{

    [self showWithText:@"该功能暂未开发！"];
}


- (void)getOrderInfo
{
    if (FBIsEmpty(self.orderId)) {
        [self showWithText:@"订单id不能为空"];
    }
    self.hTMPOrderInfoHttp.parameter.orderid = self.orderId;
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTOrderResultViewController *weak_self = self;
    [self.hTMPOrderInfoHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.hTMPOrderInfoHttp.isValid) {
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.hTMPOrderInfoHttp.erorMessage];
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


# pragma mark -
# pragma mark - ALiXPay
- (void)createOrderAndSignToAliPay
{
    /*
	 *生成订单信息及签名
	 *由于demo的局限性，采用了将私钥放在本地签名的方法，商户可以根据自身情况选择签名方法(为安全起见，在条件允许的前提下，我们推荐从商户服务器获取完整的订单信息)
	 */
    NSString *appScheme = @"HuiTuTicket";
    NSString* orderInfo = [self fillOrderInfo];
    NSString* signedStr = [self doRsa:orderInfo];
    LXLog(@"%@",signedStr);
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];
}

- (void)paymentResultDelegate:(NSString *)result
{
    LXLog(@"%@",result);
}

//wap回调函数
- (void)paymentResult:(NSString *)resultd
{
    LXLog(@"result str%@",resultd);
    //结果处理
    AlixPayResult* result = [[AlixPayResult alloc] initWithString:resultd];
	if (result)
    {
		if (result.statusCode == 9000)
        {
			/*
			 *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
			 */
            //交易成功
            NSString* key = AlipayPubKey;//签约帐户后获取到的支付宝公钥
			id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
			if ([verifier verifyString:result.resultString withSign:result.signString])
            {//验证签名成功，交易结果无篡改
                LXLog(@"验证签名成功，交易结果无篡改");
                //FIXME: 这里需要补充或修改
			}
        }
        else
        {   //交易失败
            LXLog(@"交易失败,result.statusCode ==%d",result.statusCode);
        }
    }
    else
    {   //失败
        LXLog(@"交易失败");
    }
}

-(NSString*)fillOrderInfo
{
    /*
	 *获取Sp实例,并初始化订单信息
	 */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = self.hTMPOrderInfoHttp.resultModel.trade_no; //订单ID（由商家自行制定）
    order.productName = self.hTMPOrderInfoHttp.resultModel.subject; //商品标题
    order.productDescription = [NSString stringWithFormat:@"%@",self.hTMPOrderInfoHttp.resultModel.subject]; //商品描述
#warning 价格这里需要处理
    if (!FBIsEmpty(self.totalMoney)) {
        order.amount = self.totalMoney;
    }
    else {
        order.amount = self.hTMPOrderInfoHttp.resultModel.total_fee;
    }
    
//    order.amount = @"0.01"; //商品价格
    order.notifyURL =  self.hTMPOrderInfoHttp.resultModel.notify_url; //回调URL
	return [order description];
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}

#pragma mark -
#pragma mark - NOTIFICATION
-(void)aliPayFinish:(NSNotification *)notification
{
    AlixPayResult *result =notification.object;
    if (result.statusCode == 9000)
    {
        /*
         *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
         */
        //交易成功
        NSString* key = AlipayPubKey;
        id<DataVerifier> verifier;
        verifier = CreateRSADataVerifier(key);
        if ([verifier verifyString:result.resultString withSign:result.signString])
        {
            //验证签名成功，交易结果无篡改
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"支付成功！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        //交易失败
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"支付失败" message:result.statusMessage delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}


@end
