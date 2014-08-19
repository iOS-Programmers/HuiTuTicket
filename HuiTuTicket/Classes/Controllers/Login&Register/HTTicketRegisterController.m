//
//  HTTicketRegisterController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTicketRegisterController.h"
#import "HTRegisterSuccessController.h"
#import "HTTicketBindingController.h"
#import "TicketRegisterHttp.h"
#import "TicketBindHttp.h"

@interface HTTicketRegisterController ()

@property (strong, nonatomic) TicketRegisterHttp *ticketRegisterHttp;

@property (strong, nonatomic) TicketBindHttp *ticketBindHttp;

@property (weak, nonatomic) IBOutlet UITextField *ticketNumTF;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *IDNumTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;


- (IBAction)onRegisterBtnClick:(id)sender;

- (IBAction)onBindingBtnClick:(id)sender;
@end

@implementation HTTicketRegisterController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"联票注册";
        _ticketBindHttp = [[TicketBindHttp alloc] init];
        _ticketRegisterHttp = [[TicketRegisterHttp alloc] init];
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
 *  请求联票注册接口
 *
 */
- (IBAction)onRegisterBtnClick:(id)sender {
    

    self.ticketRegisterHttp.parameter.codenumber = @"328004867679";
    self.ticketRegisterHttp.parameter.username = @"姜英辉";
    self.ticketRegisterHttp.parameter.sex = @"0";
    self.ticketRegisterHttp.parameter.mobile = @"18638616155";
    self.ticketRegisterHttp.parameter.idtype = @"0";
    self.ticketRegisterHttp.parameter.idcard = @"41010199001011010";
    self.ticketRegisterHttp.parameter.citycode = @"410101";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketRegisterController *weak_self = self;
    [self.ticketRegisterHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.ticketRegisterHttp.isValid) {
            [weak_self showWithText:@"联票注册成功"];
            [self bindTicket];

        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.ticketRegisterHttp.erorMessage];
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
//    [self pushViewController:@"HTRegisterSuccessController"];
}

/**
 *  联票绑定
 */
- (void)bindTicket
{
    self.ticketBindHttp.parameter.uid = @"2";
    self.ticketBindHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.ticketBindHttp.parameter.lpcode = @"328004867679";
    self.ticketBindHttp.parameter.lpuser = @"姜英辉";
    self.ticketBindHttp.parameter.typename = @"0";
    self.ticketBindHttp.parameter.typepic = @"";
    self.ticketBindHttp.parameter.endtime = @"0";
    self.ticketBindHttp.parameter.regtime = @"0";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketRegisterController *weak_self = self;
    [self.ticketBindHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.ticketBindHttp.isValid) {
            [weak_self showWithText:@"联票绑定成功"];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.ticketBindHttp.erorMessage];
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

- (IBAction)onBindingBtnClick:(id)sender {
    
    [self pushViewController:@"HTTicketBindingController"];
}
@end
