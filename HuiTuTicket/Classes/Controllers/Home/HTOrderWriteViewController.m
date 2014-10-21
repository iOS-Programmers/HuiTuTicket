//
//  HTOrderWriteViewController.m
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTOrderWriteViewController.h"
#import "HTScenicDetailViewCell.h"
#import "HTOrderResultViewController.h"
#import "HTOrderResultViewController.h"
#import "TicketOrderSubmitHttp.h"
#import "HTMPOrderInfoHttp.h"

#import "ScenicDetail.h"

//AlixPay
#import "PartnerConfig.h"
#import "DataSigner.h"
#import "AlixPayResult.h"
#import "DataVerifier.h"
#import "AlixPayOrder.h"
#import "AlixLibService.h"

@interface HTOrderWriteViewController ()

/******详情View*******/
@property (nonatomic, strong) IBOutlet UIView *headView;

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *payType;
@property (weak, nonatomic) IBOutlet UILabel *scenicIntroduceLabel;

@property (weak, nonatomic) IBOutlet UIButton *changeDateBtn;

- (IBAction)onChangeDateClick:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *idCardTF;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;



@property (nonatomic,strong) TicketOrderSubmitHttp *ticketOrderSubmitHttp;
@property (nonatomic,strong) HTMPOrderInfoHttp *hTMPOrderInfoHttp;


- (IBAction)plusAction:(id)sender;
- (IBAction)minusAction:(id)sender;
- (IBAction)payAction:(id)sender;

@end

@implementation HTOrderWriteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"订单填写";
        self.ticketOrderSubmitHttp = [[TicketOrderSubmitHttp alloc] init];
        self.hTMPOrderInfoHttp = [[HTMPOrderInfoHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = view;
    [self refreshUIShow];
    
    LXLog(@"--- %@",self.ticketDetail);
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(ticketBuyAction:)
                                                 name:BUY_MP_NOTIFICATON
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(aliPayFinish:)
                                                 name:ALIPAY_DONE
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:BUY_MP_NOTIFICATON object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALIPAY_DONE object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getOrderInfo
{
    self.hTMPOrderInfoHttp.parameter.orderid = self.ticketOrderSubmitHttp.resultModel.orderId;
    [self showLoadingWithText:kLOADING_TEXT];
    __weak HTOrderWriteViewController *weak_self = self;
    [self.hTMPOrderInfoHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.hTMPOrderInfoHttp.isValid) {
            [weak_self createOrderAndSignToAliPay];
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

- (void)submitOrder:(ScenicDetail *)info
{
    self.ticketOrderSubmitHttp.parameter.scenicid = self.scenicId;
//    self.ticketOrderSubmitHttp.parameter.ticketid = info.ticketId;
    self.ticketOrderSubmitHttp.parameter.number = self.numberLabel.text;
    self.ticketOrderSubmitHttp.parameter.travel_time = @"2014-09-20";
    self.ticketOrderSubmitHttp.parameter.receive_name = @"风暴";
    self.ticketOrderSubmitHttp.parameter.receive_moblie = @"13205810687";

    [self showLoadingWithText:kLOADING_TEXT];
    __weak HTOrderWriteViewController *weak_self = self;
    [self.ticketOrderSubmitHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.ticketOrderSubmitHttp.isValid) {
            [weak_self getOrderInfo];
            //FIXME: 这里需要补充或修改
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.ticketOrderSubmitHttp.erorMessage];
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

#pragma mark - custom
- (void)refreshUIShow
{
//    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    
    //显示景区介绍
    self.productName.text = [NSString stringWithFormat:@"产品介绍： %@",self.ticketDetail.scenicName];
    self.payType.text = [NSString stringWithFormat:@"支付方式： 在线支付"];
    self.scenicIntroduceLabel.text = self.ticketDetail.intro;
    
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height-44);
    self.totalPriceLabel.text = [NSString stringWithFormat:@"订单金额： %.2f元",[self.ticketDetail.price floatValue]*[self.numberLabel.text intValue]];
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    HTScenicDetailViewCell *cell = (HTScenicDetailViewCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTScenicDetailViewCell" owner:self options:nil] lastObject];
    }
    
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
}
#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HTOrderResultViewController *app = [[HTOrderResultViewController alloc] init];
    [self.navigationController pushViewController:app animated:YES];
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
    order.productDescription = [NSString stringWithFormat:@"%@%@",self.ticketOrderSubmitHttp.resultModel.scenicName,self.ticketOrderSubmitHttp.resultModel.ticketName]; //商品描述
    order.amount = @"0.01"; //商品价格
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

- (void)ticketBuyAction:(NSNotification *)notifaction
{
    TicketModel *info = notifaction.object;
    [self submitOrder:info];
}

# pragma mark -
# pragma mark - Action
- (IBAction)plusAction:(id)sender
{
    self.numberLabel.text = [NSString stringWithFormat:@"%d",([self.numberLabel.text intValue]+1)];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"订单金额： %.2f元",[self.ticketDetail.price floatValue]*[self.numberLabel.text intValue]];
}

- (IBAction)minusAction:(id)sender
{
    if ([self.numberLabel.text intValue]-1>=1)
    {
        self.numberLabel.text = [NSString stringWithFormat:@"%d",([self.numberLabel.text intValue]-1)];
        self.totalPriceLabel.text = [NSString stringWithFormat:@"订单金额： %f元",[self.ticketDetail.price floatValue]*[self.numberLabel.text intValue]];
    }
}

/**
 *  跳转到选择支付方式页面
 *
 */
- (IBAction)payAction:(id)sender
{
//    [self submitOrder:self.ticketDetail];
    
    HTOrderResultViewController *vc = [[HTOrderResultViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)onChangeDateClick:(UIButton *)sender {
}
@end
