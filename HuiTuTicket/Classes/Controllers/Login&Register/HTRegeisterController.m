//
//  HTRegeisterController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-28.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTRegeisterController.h"
#import "RegisterHttp.h"

@interface HTRegeisterController ()


@property (strong, nonatomic) RegisterHttp *registerHttp;

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

@end

@implementation HTRegeisterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"注册";
        
        _registerHttp = [[RegisterHttp alloc] init];
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
    
    [self.view addSubview:self.scrollView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  点击手机号页面的下一步按钮
 *
 *  @param sender
 */
- (IBAction)onPhoneNumberNextBtn:(id)sender
{
    
    [self.scrollView setContentOffset:CGPointMake(320, 0) animated:YES];
}

/**
 *  点击账号跟密码页面的下一步按钮
 *
 *  @param sender
 */
- (IBAction)onPasswordNextBtn:(id)sender
{
    [self.scrollView setContentOffset:CGPointMake(640, 0) animated:YES];
}

/**
 *  点击注册按钮
 *
 *  @param sender
 */
- (IBAction)onRegisterBtn:(id)sender {

////    self.registerHttp.parameter.mobile = self.phoneNumberTF.text;
////    self.registerHttp.parameter.password = self.pw_passwordTF.text;
////
////    self.registerHttp.parameter.sig = [HTFoundationCommon md5:[NSString stringWithFormat:@"%@%@%@",self.phoneNumberTF.text,self.pw_passwordTF.text,API_KEY]];
//    self.registerHttp.parameter.mobile = @"18638616155";
//    self.registerHttp.parameter.password = @"123456";
//    
//    self.registerHttp.parameter.sig = [HTFoundationCommon md5:[NSString stringWithFormat:@"18638616155123456%@",API_KEY]];
//
//    [self showLoadingWithText:@"加载中"];
//    __block HTRegeisterController *weak_self = self;
//    [self.registerHttp getDataWithCompletionBlock:^{
////        [weak_self hideHud];
//        if (weak_self.registerHttp.isValid)
//        {
//            [weak_self showWithText:@"注册成功"];
//
//        }
//        else
//        {   //显示服务端返回的错误提示
////            [weak_self showText:weak_self.registerHttp.erorMessage];
//        };
//        
//        [weak_self hideLoading];
//    }failedBlock:^{
//        [weak_self hideLoading];
//        if (![HTFoundationCommon networkDetect])
//        {
////            [weak_self showText:LX_CHECKNET];
//        }
//        else
//        {
//            //统统归纳为服务器出错
////            [weak_self showText:LX_NETWRONG];
//        };
//    }];
//    
////    [self showWithText:@"注册成功!"];
}
@end
