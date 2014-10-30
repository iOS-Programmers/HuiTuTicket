//
//  HTTicketBindingController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

/**
 *  已注册联票绑定--->输入票号、注册人姓名--->调用联票系统注册人验证接口，进行身份验证--<验证成功后>--> 调用手机APP联票绑定接口，完成联票与当前会员绑定
 */

#import "HTTicketBindingController.h"

#import "TicketBindHttp.h"

#import "TicketUserVerifyHttp.h"

#import "ZBarSDK.h"

@interface HTTicketBindingController () <ZBarReaderDelegate>

@property (weak, nonatomic) IBOutlet UITextField *lpCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *userNameTf;
@property (strong, nonatomic) TicketBindHttp *bindHttp;

@property (strong, nonatomic) TicketUserVerifyHttp *userVerifyHttp;
- (IBAction)onVerifyAndBindBtnClick:(id)sender;

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
        _userVerifyHttp = [[TicketUserVerifyHttp alloc] init];
    }
    return self;
}


- (UIBarButtonItem *)rightNavItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 35, 35);
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"home_saoyisao"] forState:UIControlStateNormal];
    btn.showsTouchWhenHighlighted = YES;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(rightItemClick) forControlEvents:UIControlEventTouchUpInside];
    [btn showsTouchWhenHighlighted];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
}

- (void)rightItemClick
{
    //扫一扫
    ZBarReaderViewController *reader = [ZBarReaderViewController new];
    reader.readerDelegate = self;
    reader.supportedOrientationsMask = ZBarOrientationMaskAll;
    reader.title = @"扫一扫";
    [self setOverlayPickerView:reader];
    ZBarImageScanner *scanner = reader.scanner;
    
    [scanner setSymbology: ZBAR_I25
                   config: ZBAR_CFG_ENABLE
                       to: 0];
    reader.hidesBottomBarWhenPushed = YES;
    reader.wantsFullScreenLayout = NO;
    reader.showsZBarControls = NO;
    
    [self pushNewViewController:reader];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.rightBarButtonItem = [self rightNavItem];
}
- (void)requestBingData
{

    
    
    self.bindHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    self.bindHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.bindHttp.parameter.lpcode = self.lpCodeTF.text;
    self.bindHttp.parameter.lpuser = self.userNameTf.text;
    
    
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

#pragma mark - Action

- (IBAction)onVerifyAndBindBtnClick:(id)sender
{
    
    if (FBIsEmpty(self.lpCodeTF.text)) {
        [self showWithText:@"请输入联票号码"];
        return;
    }
    else if (FBIsEmpty(self.userNameTf.text)) {
        [self showWithText:@"请输入姓名"];
        return;
    }
    [self.view endEditing:YES];
    /**
     *  先进行验证，验证成功后调用绑定接口
     */
    self.userVerifyHttp.parameter.codenumber = self.lpCodeTF.text;
    self.userVerifyHttp.parameter.username = self.userNameTf.text;
    

    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketBindingController *weak_self = self;
    [self.userVerifyHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.userVerifyHttp.isValid) {
            //验证成功后进行绑定
            [weak_self requestBingData];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.userVerifyHttp.erorMessage];
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

- (IBAction)onRegisterBtnClick:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ZBar Delegate
- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        break;
    
    self.lpCodeTF.text = symbol.data;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //扫描到联票号码，
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
