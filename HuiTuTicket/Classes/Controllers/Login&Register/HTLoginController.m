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

@interface HTLoginController ()

@property (strong, nonatomic) LoginHttp *loginHttp;
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
    }
    return self;
}

- (void)configuraBackButton
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(back)];
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


- (IBAction)onLoginBtnClick:(id)sender
{
    self.loginHttp.parameter.username = @"18638616155";
    self.loginHttp.parameter.password = @"123456";
    
    
    [self showLoadingWithText:@"加载中"];
    __block HTLoginController *weak_self = self;
    [self.loginHttp getDataWithCompletionBlock:^{
        //        [weak_self hideHud];
        if (weak_self.loginHttp.isValid)
        {
            [weak_self showWithText:@"登录成功"];
            
        }
        else
        {   //显示服务端返回的错误提示
            //            [weak_self showText:weak_self.registerHttp.erorMessage];
        };
        
        [weak_self hideLoading];
    }failedBlock:^{
        [weak_self hideLoading];
        if (![HTFoundationCommon networkDetect])
        {
            //            [weak_self showText:LX_CHECKNET];
        }
        else
        {
            //统统归纳为服务器出错
            //            [weak_self showText:LX_NETWRONG];
        };
    }];

}

- (IBAction)onFindPasswordClick:(id)sender {
    [self pushViewController:@"HTFindPasswordController"];
}

- (IBAction)onRegisterBtnClick:(id)sender
{
    [self pushViewController:@"HTRegeisterController"];
}
@end
