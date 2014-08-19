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

@interface HTTicketRegisterController ()<UITextFieldDelegate>

@property (strong, nonatomic) TicketRegisterHttp *ticketRegisterHttp;

@property (strong, nonatomic) TicketBindHttp *ticketBindHttp;

@property (weak, nonatomic) IBOutlet UITextField *ticketNumTF;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;

@property (weak, nonatomic) IBOutlet UITextField *IDNumTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;

//选择证件类型
@property (weak, nonatomic) IBOutlet UIButton *selectTypeButton;
- (IBAction)onSexButtonClick:(id)sender;

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
    self.manButton.selected = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onSexButtonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.manButton.selected = NO;
    self.womanButton.selected = NO;
    
    btn.selected = !btn.selected;
}

/**
 *  请求联票注册接口
 *
 */

- (IBAction)onRegisterBtnClick:(id)sender {
    /**
     *  判断是否数据都有填写
     */
    if (FBIsEmpty(self.ticketNumTF.text)) {
        [self showWithText:@"请输入联票号码"];
        return;
    }
    else if (FBIsEmpty(self.nameTF.text)) {
        [self showWithText:@"请输入姓名"];
        return;
    }
    else if (FBIsEmpty(self.IDNumTF.text)) {
        [self showWithText:@"请输入证件号码"];
        return;
    }
    else if (FBIsEmpty(self.phoneNumTF.text)) {
        [self showWithText:@"请输入手机号"];
        return;
    }
    else if (FBIsEmpty(self.nameTF.text)) {
        [self showWithText:@"请输入姓名"];
        return;
    }

    self.ticketRegisterHttp.parameter.codenumber = self.ticketNumTF.text;
    self.ticketRegisterHttp.parameter.username = self.nameTF.text;
    self.ticketRegisterHttp.parameter.sex = self.manButton.selected ? @"0" : @"1";
    self.ticketRegisterHttp.parameter.mobile = self.phoneNumTF.text;
    self.ticketRegisterHttp.parameter.idtype = @"0";
    self.ticketRegisterHttp.parameter.idcard = self.IDNumTF.text;
    self.ticketRegisterHttp.parameter.citycode = @"410101";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketRegisterController *weak_self = self;
    [self.ticketRegisterHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.ticketRegisterHttp.isValid) {

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

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.IDNumTF || textField == self.phoneNumTF) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view frameSetY:-120];
        }];
        
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        if (IOS7_OR_LATER) {
            [self.view frameSetY:64];
        }
        else {
            [self.view frameSetY:0];
        }
        
    }];
}
@end
