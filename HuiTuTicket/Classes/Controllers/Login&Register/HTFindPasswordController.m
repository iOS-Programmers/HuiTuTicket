//
//  HTFindPasswordController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-28.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTFindPasswordController.h"
#import "HTResetPasswdController.h"
#import "SendCodeHttp.h"

@interface HTFindPasswordController ()


@property (weak, nonatomic) IBOutlet UITextField *mobieTF;

@property (strong, nonatomic) SendCodeHttp *sendcodeHttp;

- (IBAction)onFindPasswdBtnClick:(id)sender;
@end

@implementation HTFindPasswordController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"找回密码";
        
        _sendcodeHttp = [[SendCodeHttp alloc] init];
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

/**
 *  点击找回密码
 *
 */
- (IBAction)onFindPasswdBtnClick:(id)sender
{
    
    if (FBIsEmpty(self.mobieTF.text)) {
        [self showWithText:@"请输入手机号！"];
        return;
    }
    
    [self sendCode];
}

/**
 *  发送验证码
 */
- (void)sendCode
{
    self.sendcodeHttp.parameter.mobile = self.mobieTF.text;
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTFindPasswordController *weak_self = self;
    [self.sendcodeHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.sendcodeHttp.isValid) {
            
            //获取成功后跳转
            [weak_self showWithText:@"验证码已发送，请注意查收！"];
            
            HTResetPasswdController *vc = [[HTResetPasswdController alloc] init];
            vc.mobile = weak_self.mobieTF.text;
            [weak_self.navigationController pushViewController:vc animated:YES];
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
@end
