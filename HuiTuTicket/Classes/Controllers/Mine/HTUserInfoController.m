//
//  HTUserInfoController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTUserInfoController.h"
#import "LogoutHttp.h"

@interface HTUserInfoController () <UIAlertViewDelegate>

@property (strong, nonatomic) LogoutHttp *logoutHttp;

- (IBAction)onLogoutBtnClick:(id)sender;

@end

@implementation HTUserInfoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _logoutHttp = [[LogoutHttp alloc] init];
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

- (IBAction)onLogoutBtnClick:(id)sender
{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您确认要退出登录吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
    
    
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        //退出登录
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:SESSION_KEY];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USERINFO object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
//        self.logoutHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
//        self.logoutHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
//        
//        
//        [self showLoadingWithText:kLOADING_TEXT];
//        __block HTUserInfoController *weak_self = self;
//        [self.logoutHttp getDataWithCompletionBlock:^{
//            [weak_self hideLoading];
//            
//            if (weak_self.logoutHttp.isValid) {
//                
//                /**
//                 *  退出登录成功后 移除掉sessionKey userid 返回到上个页面
//                 */
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:SESSION_KEY];
//                [[NSUserDefaults standardUserDefaults] removeObjectForKey:USER_ID];
//                
//                [[NSNotificationCenter defaultCenter] postNotificationName:UPDATE_USERINFO object:nil];
//                
//                [self.navigationController popViewControllerAnimated:YES];
//                
//                
//            }
//            else {
//                //显示服务端返回的错误提示
//                [weak_self showErrorWithText:weak_self.logoutHttp.erorMessage];
//            };
//            
//            
//        }failedBlock:^{
//            [weak_self hideLoading];
//            if (![HTFoundationCommon networkDetect]) {
//                
//                [weak_self showErrorWithText:kNETWORK_ERROR];
//            }
//            else {
//                
//                //统统归纳为服务器出错
//                [weak_self showErrorWithText:kSERVICE_ERROR];
//            };
//        }];

    }
}

@end
