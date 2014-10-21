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

#import "TicketModel.h"
#import "ScenicDetail.h"



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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  门票订单提交
 *
 *  校验串生成方法：将请求参数中的uid、scenicid、ticketid、number、travel_time、receive_moblie、key七个参数的value值拼成一个无间隔的字符串(顺序不要改变)，key是参数签名密钥。
    MD5字符串示例：
    106201307011536259678253012013-07-1613800138000key
    用32位MD5函数加密该字符串所得值即为我们所需的校验串。
    注意：得出的32位MD5值需转化为小写。
 *
 *
 */
- (void)submitOrder:(ScenicDetail *)info
{
    if (!FBIsEmpty([[HTUserInfoManager shareInfoManager]userId])) {
        self.ticketOrderSubmitHttp.parameter.uid = [[HTUserInfoManager shareInfoManager]userId];
    }
    if (!FBIsEmpty([[HTUserInfoManager shareInfoManager]sessionKey])) {
        self.ticketOrderSubmitHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager]sessionKey];
    }
    
    self.ticketOrderSubmitHttp.parameter.scenicid = self.scenicId;
    self.ticketOrderSubmitHttp.parameter.ticketid = self.model.ticketId;
    self.ticketOrderSubmitHttp.parameter.number = self.numberLabel.text;
    self.ticketOrderSubmitHttp.parameter.travel_time = @"2014-10-20";
    self.ticketOrderSubmitHttp.parameter.receive_name = @"风暴";
    self.ticketOrderSubmitHttp.parameter.receive_moblie = @"13205810687";
    self.ticketOrderSubmitHttp.parameter.sig = @"222222";

    [self showLoadingWithText:kLOADING_TEXT];
    __weak HTOrderWriteViewController *weak_self = self;
    [self.ticketOrderSubmitHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.ticketOrderSubmitHttp.isValid) {
//            [weak_self getOrderInfo];
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
    //显示景区介绍
    self.productName.text = [NSString stringWithFormat:@"产品介绍： %@",self.ticketDetail.scenicName];
    self.payType.text = [NSString stringWithFormat:@"支付方式： 在线支付"];
    self.scenicIntroduceLabel.text = self.ticketDetail.intro;
    
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
    self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, self.tableView.frame.size.height-44);
    self.totalPriceLabel.text = [NSString stringWithFormat:@"订单金额： %.2f元",[self.ticketDetail.minprice floatValue]*[self.numberLabel.text intValue]];
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


- (void)ticketBuyAction:(NSNotification *)notifaction
{
//    TicketModel *info = notifaction.object;
//    [self submitOrder:info];
}

# pragma mark -
# pragma mark - Action
- (IBAction)plusAction:(id)sender
{
    self.numberLabel.text = [NSString stringWithFormat:@"%d",([self.numberLabel.text intValue]+1)];
    self.totalPriceLabel.text = [NSString stringWithFormat:@"订单金额： %.2f元",[self.ticketDetail.minprice floatValue]*[self.numberLabel.text intValue]];
}

- (IBAction)minusAction:(id)sender
{
    if ([self.numberLabel.text intValue]-1>=1)
    {
        self.numberLabel.text = [NSString stringWithFormat:@"%d",([self.numberLabel.text intValue]-1)];
        self.totalPriceLabel.text = [NSString stringWithFormat:@"订单金额：%.2f元",[self.ticketDetail.minprice floatValue]*[self.numberLabel.text intValue]];
    }
}

/**
 *  跳转到选择支付方式页面
 *
 */
- (IBAction)payAction:(id)sender
{
    [self submitOrder:nil];
    
//    HTOrderResultViewController *vc = [[HTOrderResultViewController alloc] init];
//    
//    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)onChangeDateClick:(UIButton *)sender {
}
@end
