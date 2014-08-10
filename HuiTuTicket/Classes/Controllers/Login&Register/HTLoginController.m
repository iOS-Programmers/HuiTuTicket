//
//  HTLoginController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-23.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLoginController.h"
#import "HTLoginTextField.h"    
#import "HTRegeisterController.h"
#import "HTFindPasswordController.h"

#import "LoginHttp.h"
#import "GetUserInfoHttp.h"

@interface HTLoginController ()

@property (strong, nonatomic) LoginHttp *loginHttp;
@property (strong, nonatomic) GetUserInfoHttp *getUserInfoHttp;


@property (weak, nonatomic) IBOutlet HTLoginTextField *userNameTF;
@property (weak, nonatomic) IBOutlet HTLoginTextField *passwordTF;

- (IBAction)onLoginBtnClick:(id)sender;
- (IBAction)onFindPasswordClick:(id)sender;
- (IBAction)onRegisterBtnClick:(id)sender;

@end

@implementation HTLoginController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"登录";
        _loginHttp = [[LoginHttp alloc] init];
        _getUserInfoHttp = [[GetUserInfoHttp alloc] init];
    }
    return self;
}

- (void)configuraBackButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.userNameTF becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self configuraBackButton];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (void)back
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  点击登录按钮
 *
 */
- (IBAction)onLoginBtnClick:(id)sender
{
    if (FBIsEmpty(self.userNameTF.text)) {
        [self showErrorWithText:@"请输入手机号"];
        
        return;
    }
    else if (FBIsEmpty(self.passwordTF.text)) {
        [self showErrorWithText:@"请输入密码"];
        
        return;
    }

    
    self.loginHttp.parameter.username = self.userNameTF.text;
    self.loginHttp.parameter.password = self.passwordTF.text;
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTLoginController *weak_self = self;
    [self.loginHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
       
        if (weak_self.loginHttp.isValid) {
            [weak_self showWithText:@"登录成功"];
            [weak_self getUserInfo];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.loginHttp.erorMessage];
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
 *  获取会员信息接口
 */
- (void)getUserInfo
{
    self.getUserInfoHttp.parameter.uid = self.loginHttp.resultModel.userid;
    self.getUserInfoHttp.parameter.session_key = self.loginHttp.resultModel.session_key;
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTLoginController *weak_self = self;
    [self.getUserInfoHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.getUserInfoHttp.isValid) {
            [weak_self showWithText:@"会员信息获取成功"];
            [weak_self saveUserInfo:weak_self.getUserInfoHttp.resultModel];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.loginHttp.erorMessage];
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
 *  保存用户的信息
 */
- (void)saveUserInfo:(GetUserInfo *)info
{
    
    [[HTUserInfoManager shareInfoManager] saveUserInfo:info];
    LXLog(@"获取的会员信息   %@",info);
}

- (IBAction)onFindPasswordClick:(id)sender
{
    [self pushViewController:@"HTFindPasswordController"];
}

- (IBAction)onRegisterBtnClick:(id)sender
{
    [self pushViewController:@"HTRegeisterController"];
}
@end
