//
//  HTTicketBindingController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTicketBindingController.h"

#import "TicketBindHttp.h"

@interface HTTicketBindingController ()

@property (strong, nonatomic) TicketBindHttp *bindHttp;

- (IBAction)onRegisterBtnClick:(id)sender;

@end

@implementation HTTicketBindingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"联票绑定";
        _bindHttp = [[TicketBindHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self requestBingData];
}
- (void)requestBingData
{
    
    self.bindHttp.parameter.uid = @"2";
    self.bindHttp.parameter.session_key = @"bddfca43bf0b5955c76737e34fab386e";
     self.bindHttp.parameter.lpcode = @"100105741054";
     self.bindHttp.parameter.lpuser = @"姜英晖";
//     self.bindHttp.parameter.uid = @"2";
//     self.bindHttp.parameter.uid = @"2";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketBindingController *weak_self = self;
    [self.bindHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.bindHttp.isValid) {
            [weak_self showWithText:@"联票绑定成功"];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.bindHttp.erorMessage];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onRegisterBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
