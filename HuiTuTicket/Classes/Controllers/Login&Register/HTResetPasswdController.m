//
//  HTResetPasswdController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/10/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTResetPasswdController.h"

#import "ResetPasswordHttp.h"

@interface HTResetPasswdController ()

@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *thenewPasswdTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswdTF;

@property (strong, nonatomic) ResetPasswordHttp *resetpasswdHttp;

- (IBAction)onResetBtnClick:(UIButton *)sender;
@end

@implementation HTResetPasswdController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.resetpasswdHttp = [[ResetPasswordHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)resetData
{
    self.resetpasswdHttp.parameter.mobile = self.mobile;
    self.resetpasswdHttp.parameter.password = self.confirmPasswdTF.text;
    self.resetpasswdHttp.parameter.validcode = self.codeTF.text;
    
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTResetPasswdController *weak_self = self;
    [self.resetpasswdHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.resetpasswdHttp.isValid) {
            
            [weak_self showWithText:@"新密码修改成功!"];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weak_self.navigationController popToRootViewControllerAnimated:YES];
            });
        
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showWithText:weak_self.resetpasswdHttp.erorMessage];
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

/**
 *  点击提交
 *
 */
- (IBAction)onResetBtnClick:(UIButton *)sender {

    if (FBIsEmpty(self.mobile)) {
        [self showWithText:@"手机号输入有误"];
        
        return;
    }
    
    if (FBIsEmpty(self.codeTF.text)) {
        [self showWithText:@"请输入验证码"];
        
        return;
    }
    if (FBIsEmpty(self.thenewPasswdTF.text) || FBIsEmpty(self.confirmPasswdTF.text)) {
        [self showWithText:@"请输入密码"];
        
        return;
    }
    if (![self.thenewPasswdTF.text isEqualToString:self.confirmPasswdTF.text ]) {
        [self showWithText:@"两次输入密码不一致！"];
        
        return;
    }
    
    [self resetData];
}
@end
