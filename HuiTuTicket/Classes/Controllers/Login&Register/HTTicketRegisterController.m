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

#import "HTCityListViewController.h"
#import "HTLoginController.h"

#import "ZBarSDK.h"

@interface HTTicketRegisterController ()<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate,ZBarReaderDelegate,CityListDelegate>

@property (strong, nonatomic) TicketRegisterHttp *ticketRegisterHttp;

@property (strong, nonatomic) TicketBindHttp *ticketBindHttp;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *toolBar;

@property (strong, nonatomic) NSMutableArray *pickerArray;

/*****UI  控件********/
@property (weak, nonatomic) IBOutlet UITextField *ticketNumTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *manButton;
@property (weak, nonatomic) IBOutlet UIButton *womanButton;

@property (weak, nonatomic) IBOutlet UITextField *IDNumTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;

@property (weak, nonatomic) IBOutlet UIView *ticketbgView;
//选择证件类型
@property (weak, nonatomic) IBOutlet UIButton *selectTypeButton;
//选择城市
@property (weak, nonatomic) IBOutlet UIButton *selectCityButton;

/*****点击事件*****/
- (IBAction)onSexButtonClick:(id)sender;

- (IBAction)onSelectTypeBtnClick:(id)sender;

- (IBAction)onRegisterBtnClick:(id)sender;

- (IBAction)onBindingBtnClick:(id)sender;

- (IBAction)onSelectCityBtnClick:(id)sender;
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
        
        _pickerArray = [[NSMutableArray alloc] initWithArray:@[@"身份证",@"军官证"]];
    }
    return self;
}

#pragma mark - View Lifecycle
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [self rightNavItem];
    
    //上级页面传过来的联票号码，如果有值，则在页面自动填上
    if (!FBIsEmpty(self.lpCodeNumer)) {
        self.ticketNumTF.text = self.lpCodeNumer;
    }
    
    self.manButton.selected = YES;
    //默认证件类型是身份证
    self.ticketRegisterHttp.parameter.idtype = @"0";
    
    self.selectTypeButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.selectTypeButton.layer.borderWidth = 0.5;
    self.selectTypeButton.layer.cornerRadius = 6.0;

    
    self.selectCityButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.selectCityButton.layer.borderWidth = 0.5;
    self.selectCityButton.layer.cornerRadius = 6.0;
    
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height + 44, 320, 162)];
    _pickerView.backgroundColor = kColorWhite;
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    [self.view addSubview:_pickerView];
    
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,  [UIScreen mainScreen].applicationFrame.size.height, 320, 44)];
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    UIBarButtonItem *myDoneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                                  target: self
                                                                                  action: @selector(hidePickerView)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexibleSpace];
    [buttons addObject: myDoneButton];
    [self.toolBar setItems:buttons animated:TRUE];

    [self.view addSubview:_toolBar];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (void)hidePickerView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height, 320, 44);
    self.pickerView.frame = CGRectMake(0, self.view.frame.size.height+44, 320, 162);
    [UIView commitAnimations];
}

- (void)showPickerView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - 162-44, 320, 44);
    self.pickerView.frame = CGRectMake(0, self.view.frame.size.height - 162, 320, 162);
    [UIView commitAnimations];
}

- (IBAction)onSexButtonClick:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    self.manButton.selected = NO;
    self.womanButton.selected = NO;
    
    btn.selected = !btn.selected;
}

/**
 *  点击显示pickerview
 *
 *  @param sender
 */
- (IBAction)onSelectTypeBtnClick:(id)sender
{
    [self showPickerView];
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

/**
 *  请求联票注册接口
 *
 */

- (IBAction)onRegisterBtnClick:(id)sender {
    
    
    
    [self clearKeyboard];
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
    }else if (![NSString validateIDCardNumber:self.IDNumTF.text])
    {
        [self showWithText:@"请出入正确的证件号码"];
        return;
    }
    else if (FBIsEmpty(self.phoneNumTF.text)) {
        [self showWithText:@"请输入手机号"];
        return;
    }
    else if (![NSString isValidateMobile:self.phoneNumTF.text]) {
        [self showWithText:@"请输入正确的手机号"];
        return;
    }
    else if (FBIsEmpty(self.nameTF.text)) {
        [self showWithText:@"请输入姓名"];
        return;
    }
    
    [self.view endEditing:YES];

    self.ticketRegisterHttp.parameter.codenumber = self.ticketNumTF.text;
    self.ticketRegisterHttp.parameter.username = self.nameTF.text;
    self.ticketRegisterHttp.parameter.sex = self.manButton.selected ? @"0" : @"1";
    self.ticketRegisterHttp.parameter.mobile = self.phoneNumTF.text;
//    self.ticketRegisterHttp.parameter.idtype = @"0";
    self.ticketRegisterHttp.parameter.idcard = self.IDNumTF.text;
    self.ticketRegisterHttp.parameter.citycode = @"410101";
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketRegisterController *weak_self = self;
    [self.ticketRegisterHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.ticketRegisterHttp.isValid) {

            //注册成功后，与当前账号进行绑定
            [self bindTicket];
            [self showWithText:@"注册联票成功"];

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
    self.ticketBindHttp.parameter.uid = [[HTUserInfoManager shareInfoManager] userId];
    
    self.ticketBindHttp.parameter.session_key = [[HTUserInfoManager shareInfoManager] sessionKey];
    self.ticketBindHttp.parameter.lpcode =FBIsEmpty(self.ticketNumTF.text) ? @"" : self.ticketNumTF.text;
    self.ticketBindHttp.parameter.mobile = self.phoneNumTF.text;


//    self.ticketBindHttp.parameter.lpuser = @"";
//    self.ticketBindHttp.parameter.typename = @"0";
//    self.ticketBindHttp.parameter.typepic = @"";
//    self.ticketBindHttp.parameter.endtime = @"0";
//    self.ticketBindHttp.parameter.regtime = @"0";
    
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
    
    NSString *uid =[[HTUserInfoManager shareInfoManager] userId];
    NSString *session_key =[[HTUserInfoManager shareInfoManager] sessionKey];
    if (FBIsEmpty(uid)||FBIsEmpty(session_key)) {
        [self showWithText:@"请登录"];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[[HTLoginController alloc] init]];
        [self presentViewController:nav animated:YES completion:nil];
        
        return;
    }
    [self pushViewController:@"HTTicketBindingController"];
}
- (IBAction)onSelectCityBtnClick:(id)sender
{
    HTCityListViewController *cityListVC = [[HTCityListViewController alloc]init];
    cityListVC.delegate = self;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:cityListVC];

    [self presentViewController:nav animated:YES completion:nil];
}
#pragma mark - CiytDelegate
- (void)controller:(HTCityListViewController *)controller city:(NSString *)city
{
    [self.selectCityButton setTitle:city forState:UIControlStateNormal];
}
#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 2;
}

/*return component row str*/
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerArray objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (row == 0) {
        //身份证
        self.ticketRegisterHttp.parameter.idtype = @"0";
        [self.selectTypeButton setTitle:@"身份证" forState:UIControlStateNormal];
    }
    else {
        //军官证
        self.ticketRegisterHttp.parameter.idtype = @"1";
        [self.selectTypeButton setTitle:@"军官证" forState:UIControlStateNormal];
    }
}

#pragma mark - UITextField Delegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.IDNumTF || textField == self.phoneNumTF || textField == self.addressTF) {
        [UIView animateWithDuration:0.3 animations:^{
            [self.view frameSetY:-120];
        }];
        
    }
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
    
    self.ticketNumTF.text = symbol.data;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //扫描到联票号码，
        [self.navigationController popViewControllerAnimated:YES];
    });
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self clearKeyboard];
}
- (void)clearKeyboard
{
    [super clearKeyboard];
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
