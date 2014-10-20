//
//  HTRegeisterController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-28.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTRegeisterController.h"
#import "RegisterHttp.h"
#import "SendCodeHttp.h"

@interface HTRegeisterController ()
{
    NSTimer *timer;
    
    int countDownTime;
}


@property (strong, nonatomic) RegisterHttp *registerHttp;

@property (strong, nonatomic) SendCodeHttp *sendcodeHttp;

@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageVerifyLabel;

//主ScrollView
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

/***********手机号页面***********/
@property (strong, nonatomic) IBOutlet UIView *phoneNumerView;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *phoneNumberNextBtn;

- (IBAction)onPhoneNumberNextBtn:(id)sender;

/***********密码页面***********/
@property (strong, nonatomic) IBOutlet UIView *passwordView;
@property (weak, nonatomic) IBOutlet UITextField *pw_phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *pw_passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *pw_NextBtn;

- (IBAction)onPasswordNextBtn:(id)sender;

/***********验证码页面***********/
@property (strong, nonatomic) IBOutlet UIView *messageVerifyView;
@property (weak, nonatomic) IBOutlet UITextField *mv_verifyTF;
@property (weak, nonatomic) IBOutlet UIButton *mv_SendBtn;
@property (weak, nonatomic) IBOutlet UILabel *mv_sendtoPhoneLabel;
@property (weak, nonatomic) IBOutlet UIButton *mv_RegisterBtn;

- (IBAction)onRegisterBtn:(id)sender;
- (IBAction)onSendCodeBtnClick:(id)sender;

@end

@implementation HTRegeisterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册";
        
        _registerHttp = [[RegisterHttp alloc] init];
        
        _sendcodeHttp = [[SendCodeHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self configureView];
}



/**
 *  配置界面
 */
- (void)configureView
{
    [self.scrollView setFrame:CGRectMake(0, 30, 320, 538)];
    [self.scrollView setContentSize:CGSizeMake(320*3, 538)];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView setScrollEnabled:NO];
    
    //添加点击取消键盘的方法
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(clickBackgroud)];
    [self.scrollView addGestureRecognizer:tap];
    
    [self.view addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Aciton

- (void)clickBackgroud
{
    [self.scrollView endEditing:YES];
}

/**
 *  点击手机号页面的下一步按钮
 *
 *  @param sender
 */
- (IBAction)onPhoneNumberNextBtn:(id)sender
{
    
    if (FBIsEmpty(self.phoneNumberTF.text)) {
        [self showErrorWithText:@"请输入手机号"];
        
        return;
    }
    
    self.pw_phoneNumTF.text = self.phoneNumberTF.text;
    
    [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
}

/**
 *  点击账号跟密码页面的下一步按钮
 *
 *  @param sender
 */
- (IBAction)onPasswordNextBtn:(id)sender
{
    if (FBIsEmpty(self.pw_phoneNumTF.text)) {
        [self showErrorWithText:@"请输入手机号"];
        
        return;
    }
    else if (FBIsEmpty(self.pw_passwordTF.text)) {
        [self showErrorWithText:@"请输入密码"];
        
        return;
    }
    else if (self.pw_passwordTF.text.length < 6 || self.pw_passwordTF.text.length > 18) {
        [self showErrorWithText:@"输入的密码不符合密码规则"];
        
        return;
    }
    
    [self.scrollView setContentOffset:CGPointMake(640, 0) animated:YES];
    
    self.mv_sendtoPhoneLabel.text = [NSString stringWithFormat:@"已将短信验证码发送至您手机%@",self.pw_phoneNumTF.text];
    
    //请求发送验证码
    [self onSendCodeBtnClick:nil];
}

/**
 *  点击注册按钮
 *
 *  @param sender
 */
- (IBAction)onRegisterBtn:(id)sender {

    self.registerHttp.parameter.mobile = self.phoneNumberTF.text;
    self.registerHttp.parameter.password = self.pw_passwordTF.text;

    self.registerHttp.parameter.sig = [HTFoundationCommon md5:[NSString stringWithFormat:@"%@%@%@",self.phoneNumberTF.text,self.pw_passwordTF.text,[HTFoundationCommon getAPI_KEY]]];


    [self showLoadingWithText:kLOADING_TEXT];
    __block HTRegeisterController *weak_self = self;
    [self.registerHttp getDataWithCompletionBlock:^{

        if (weak_self.registerHttp.isValid)
        {
            [weak_self showWithText:@"注册成功"];

        }
        else
        {   //显示服务端返回的错误提示
            [weak_self showWithText:weak_self.registerHttp.erorMessage];
        };
        
        [weak_self hideLoading];
    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect])
        {
            [weak_self showErrorWithText:kNETWORK_ERROR];
        }
        else
        {
            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
    
}

/**
 *  点击发送验证码
 *
 *  @param sender
 */
- (IBAction)onSendCodeBtnClick:(id)sender
{
    self.sendcodeHttp.parameter.mobile = self.pw_phoneNumTF.text;

    [self showLoadingWithText:kLOADING_TEXT];
    __block HTRegeisterController *weak_self = self;
    [self.sendcodeHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];

        if (weak_self.sendcodeHttp.isValid) {
            //发送成功
            
            //获取成功后
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:weak_self selector:@selector(countDown) userInfo:nil repeats:YES];
            countDownTime = 60;
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showWithText:weak_self.sendcodeHttp.erorMessage];
        };


    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect]) {

            [weak_self showWithText:kNETWORK_ERROR];
        }
        else {

            //统统归纳为服务器出错
            [weak_self showErrorWithText:kSERVICE_ERROR];
        };
    }];
}

//倒计时操作
- (void)countDown
{
    countDownTime --;
    if (countDownTime == 0)
    {
        if ([timer isValid]) {

            [timer invalidate];
            [self changeButtonState];
            return;
        }
    }
    [self.mv_SendBtn setTitle:[NSString stringWithFormat:@"已发送(%d)",countDownTime] forState:UIControlStateNormal];

    self.mv_SendBtn.userInteractionEnabled = NO;
    
}

- (void)changeButtonState{
    
    self.mv_SendBtn.userInteractionEnabled = YES;

    [self.mv_SendBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
}
@end
