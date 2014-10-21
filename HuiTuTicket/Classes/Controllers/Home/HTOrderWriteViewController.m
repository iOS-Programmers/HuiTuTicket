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

#define DATEPICKER_HEIGHT 216


@interface HTOrderWriteViewController () <UITextFieldDelegate>

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

//日期pickerview
@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic,retain) UIToolbar *toolBar;
@property (copy, nonatomic)NSString *dateStr;


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
    
    [self loadUI];
    
}

- (void)loadUI
{
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height + 44, 320, 216)];
    
    if (IOS7_OR_LATER) {
        [_datePicker setBackgroundColor:kColorWhite];
    }
    
    [_datePicker setTimeZone:[NSTimeZone systemTimeZone]];
    [_datePicker setDate:[NSDate date] animated:YES];
    [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:2*24*60*60]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,  [LXUtils GetScreeHeight]-44, [LXUtils GetScreeWidth], 44)];
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    UIBarButtonItem *myDoneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                                  target: self
                                                                                  action: @selector(dateFinished)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexibleSpace];
    [buttons addObject: myDoneButton];
    [self.toolBar setItems:buttons animated:YES];
    
    [self.view addSubview:_toolBar];
    
}

- (void)datePickerValueChanged:(id)sender
{
    NSDate *select = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.dateStr = [dateFormatter stringFromDate:select];
    
    [self.changeDateBtn setTitle:self.dateStr forState:UIControlStateNormal];
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
    self.ticketOrderSubmitHttp.parameter.travel_time = self.dateStr;
    self.ticketOrderSubmitHttp.parameter.receive_name = self.userNameTF.text;
    self.ticketOrderSubmitHttp.parameter.receive_moblie = self.phoneTF.text;
    
    
    NSString *sig = [HTFoundationCommon md5:[NSString stringWithFormat:@"%@%@%@%@%@%@%@",
                                             self.ticketOrderSubmitHttp.parameter.uid,
                                             self.scenicId,
                                             self.model.ticketId,
                                             self.numberLabel.text,
                                             self.ticketOrderSubmitHttp.parameter.travel_time,
                                             self.ticketOrderSubmitHttp.parameter.receive_moblie,
                                             API_KEY]];
    
    self.ticketOrderSubmitHttp.parameter.sig = sig;

    [self showLoadingWithText:kLOADING_TEXT];
    __weak HTOrderWriteViewController *weak_self = self;
    [self.ticketOrderSubmitHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.ticketOrderSubmitHttp.isValid) {

            /**
             *  获取成功后跳转到选择支付方式页面
             */
            
            HTOrderResultViewController *vc = [[HTOrderResultViewController alloc] init];
            vc.orderId = weak_self.ticketOrderSubmitHttp.resultModel.orderId;
            vc.produtName = weak_self.ticketOrderSubmitHttp.resultModel.scenicName;
            vc.traveDate = weak_self.dateStr;
            vc.totalMoney = weak_self.ticketOrderSubmitHttp.resultModel.totalamount;
            vc.number = self.numberLabel.text;
            
            [weak_self.navigationController pushViewController:vc animated:YES];
            
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

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    HTOrderResultViewController *app = [[HTOrderResultViewController alloc] init];
//    [self.navigationController pushViewController:app animated:YES];
//}


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
 * 先提交订单，再跳转到选择支付方式页面
 *
 */
- (IBAction)payAction:(id)sender
{
    if (FBIsEmpty(self.changeDateBtn.titleLabel.text)) {
        [self showWithText:@"请选择日期"];
        return;
    }
 
    if (FBIsEmpty(self.userNameTF.text)) {
        [self showWithText:@"请输入姓名"];
        return;
    }
    if (FBIsEmpty(self.phoneTF.text)) {
        [self showWithText:@"请输入手机号"];
        return;
    }if (FBIsEmpty(self.idCardTF.text)) {
        [self showWithText:@"请输入身份证"];
        return;
    }
    
    
    [self submitOrder:nil];
    
    
}
- (IBAction)onChangeDateClick:(UIButton *)sender {

    [self showDateSelector];
}

- (void)dateFinished
{
    [self clearKeyboard];
}

-(void)hideDatePicker
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height + 100, 320, 44);
    self.datePicker.frame = CGRectMake(0, self.view.frame.size.height+ 100+44, 320, 216);
    [UIView commitAnimations];
}

- (void)clearKeyboard
{
    [self hideDatePicker];

    [self.view endEditing:YES];
    [super clearKeyboard];

}

- (void)showDateSelector
{

    [self.view bringSubviewToFront:self.toolBar];
    [self.view bringSubviewToFront:self.datePicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - DATEPICKER_HEIGHT-44, 320, 44);
    self.datePicker.frame = CGRectMake(0, self.view.frame.size.height - DATEPICKER_HEIGHT, 320, DATEPICKER_HEIGHT);
    [UIView commitAnimations];
}


#pragma mark - UITextField Delegate
#define IOS7_ORIGEN_Y 64
#define IOS6_ORIGEN_Y 0
/**
 *  判断不同尺寸，不同系统的view应该上移的高度
 *  1.iOS7系统,4Inch屏幕上移 90就可以
 *  2.iOS7系统，3.5Inch屏幕，在输入时候需上移150
 *  3.iOS7view坐标从(0,0)开始, iOS6的view坐标从（0,64）开始
 *
 *  @param textField 输入框
 *
 *  @return
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    float yOrigin = (IOS7_OR_LATER ? IOS7_ORIGEN_Y : IOS6_ORIGEN_Y) - 150;
    
    if (CGRectGetMidY(self.view.frame)  < -10) {
        return YES;
    }

//    if (!INCH4) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view frameSetY: - 150];
        }];
        return YES;
//    }


//    else {
//
//        [UIView animateWithDuration:0.3 animations:^{
//            [self.view frameSetY:yOrigin];
//        }];
//    }


//    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (CGRectGetMidY(self.view.frame) != IOS7_OR_LATER ? IOS7_ORIGEN_Y : IOS6_ORIGEN_Y) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view frameSetY:IOS7_OR_LATER ? IOS7_ORIGEN_Y : IOS6_ORIGEN_Y];
        }];
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
@end
