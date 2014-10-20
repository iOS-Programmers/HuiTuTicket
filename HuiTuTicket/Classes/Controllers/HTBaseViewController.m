//
//  HTBaseViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HT. All rights reserved.
//

#import "HTBaseViewController.h"
#import "ASIFormDataRequest.h"
#import "MBProgressHUD.h"


@interface HTBaseViewController () <MBProgressHUDDelegate>

@property (nonatomic, strong) ASIFormDataRequest *baseRequest;

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, copy) HTBarButtonItemActionBlock barbuttonItemAction;

@property (nonatomic,retain)UIControl *ctrlView;

@end

@implementation HTBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _ctrlView = [[UIControl alloc] init];
    }
    return self;
}

- (void)clickedBarButtonItemAction {
    if (self.barbuttonItemAction) {
        self.barbuttonItemAction();
    }
}

#pragma mark - Public Method

- (void)configureBarbuttonItemStyle:(HTBarbuttonItemStyle)style action:(HTBarButtonItemActionBlock)action {
    switch (style) {
        case kHTBarbuttonItemSettingStyle: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_set"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        case kHTBarbuttonItemMoreStyle: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"barbuttonicon_more"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        case kHTBarbuttonItemCameraStyle: {
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"album_add_photo"] style:UIBarButtonItemStyleBordered target:self action:@selector(clickedBarButtonItemAction)];
            break;
        }
        default:
            break;
    }
    self.barbuttonItemAction = action;
}

- (void)setupBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}

- (void)clearKeyboard
{
    [self.view endEditing:YES];
}
- (void)setControlView:(id)sender
{
    self.ctrlView.autoresizesSubviews = YES;
    UIView *view = (UIView *)sender;
    self.ctrlView.frame = view.bounds;
    self.ctrlView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.ctrlView.autoresizesSubviews = YES;
    [_ctrlView addTarget:self action:@selector(clearKeyboard)forControlEvents:UIControlEventTouchUpInside];
    if ([sender isKindOfClass:[UIView class]])
    {
        [(UIView *)sender addSubview:self.ctrlView];
        [(UIView *)sender sendSubviewToBack:self.ctrlView];
    }
}

- (void)setOverlayPickerView:(ZBarReaderViewController *)reader
{
    //清除原有控件
    
    for (UIView *temp in [reader.view subviews]) {
        
        for (UIButton *button in [temp subviews]) {
            
            if ([button isKindOfClass:[UIButton class]]) {
                
                [button removeFromSuperview];
                
            }
            
        }
        
        for (UIToolbar *toolbar in [temp subviews]) {
            
            if ([toolbar isKindOfClass:[UIToolbar class]]) {
                
                [toolbar setHidden:YES];
                
                [toolbar removeFromSuperview];
                
            }
            
        }
        
    }
    
    //画中间的基准线
    
    UIView* line = [[UIView alloc] initWithFrame:CGRectMake(40, 220, 240, 1)];
    
    line.backgroundColor = [UIColor redColor];
    
    [reader.view addSubview:line];
    
    
    //最上部view
    
    UIView* upView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 80)];
    
    upView.alpha = 0.3;
    
    upView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:upView];
    
    //用于说明的label
    
    UILabel * labIntroudction= [[UILabel alloc] init];
    
    labIntroudction.backgroundColor = [UIColor clearColor];
    
    labIntroudction.frame=CGRectMake(15, 20, 290, 50);
    
    labIntroudction.numberOfLines=2;
    
    labIntroudction.textColor=[UIColor whiteColor];
    
    labIntroudction.text=@"将二维码或条码图像置于矩形方框内，离手机摄像头10CM左右，系统会自动识别。";
    
    [upView addSubview:labIntroudction];
    
    
    //左侧的view
    
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, 20, 280)];
    
    leftView.alpha = 0.3;
    
    leftView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:leftView];
    
    
    //右侧的view
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(300, 80, 20, 280)];
    
    rightView.alpha = 0.3;
    
    rightView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:rightView];
    
    
    //底部view
    
    UIView * downView = [[UIView alloc] initWithFrame:CGRectMake(0, 360, 320, 250)];
    
    downView.alpha = 0.3;
    
    downView.backgroundColor = [UIColor blackColor];
    
    [reader.view addSubview:downView];
    
    
}

#pragma mark - Http Request
/*
 * 请求数据
 */
- (void)requestData:(NSArray *)parameterName parameterValue:(NSArray *)parameterValue Url:(NSString *)url tag:(int)tag {
    NSURL *urls = [NSURL URLWithString:[NSString stringWithFormat:@"%@",url]];
    _baseRequest = [[ASIFormDataRequest alloc] initWithURL:urls];
	
    [_baseRequest setRequestMethod:@"POST"];
    [_baseRequest setDelegate:self];
    //	[request addRequestHeader:@"User-Agent" value:@"application/x-www-form-urlencoded"];
    
	[_baseRequest setTimeOutSeconds:15];
    for (int i = 0; i <[parameterName count]; i ++) {
        [_baseRequest setPostValue:parameterValue[i] forKey:parameterName[i]];
        
        LXLog(@"value----- %@  name ---  %@",parameterValue[i],parameterName[i]);
    }

    _baseRequest.tag = tag;
    [_baseRequest setDidFailSelector:@selector(postrequestDidFailed:)];
    [_baseRequest setDidFinishSelector:@selector(postrequestDidSuccess:)];
    [_baseRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [_baseRequest setResponseEncoding:NSUTF8StringEncoding];
    [_baseRequest startAsynchronous];
    
}

//子类重写
- (void)postrequestDidSuccess:(ASIFormDataRequest *)request{
    
}

- (void)postrequestDidFailed:(ASIFormDataRequest *)request
{
    
}


#pragma mark - ViewController presentModal

- (void)lxPushViewController:(NSString *)className animated:(BOOL)animated {
    Class cls = NSClassFromString(className);
    NSAssert1(cls, @"could not find class '%@'",className);
    id obj = [[cls alloc] initWithNibName:className bundle:nil];
    
    [self.navigationController pushViewController:obj animated:animated];
    
}

- (void)pushViewController:(NSString *)className {
    [self lxPushViewController:className animated:YES];
}

- (void)pushViewControllerNoAnimated:(NSString *)className {
    [self lxPushViewController:className animated:NO];
}

#pragma mark - Loading


- (void)showLoading {
    [self showLoadingWithText:nil];
}

- (void)showLoadingWithText:(NSString *)text {
    [self showLoadingWithText:text onView:self.view];
}

- (void)showLoadingWithText:(NSString *)text onView:(UIView *)view {
    
    _hud = [[MBProgressHUD alloc] initWithView:view];
    [self.view addSubview:_hud];
    _hud.labelText = text;
    _hud.yOffset = -10.f;
    
    [_hud show:YES];
}

- (void)showSuccess {
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_hud];
	
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	_hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	_hud.mode = MBProgressHUDModeCustomView;
	
	_hud.delegate = self;
	_hud.labelText = @"完成";
	
	[_hud show:YES];
	[_hud hide:YES afterDelay:2];

}
- (void)showErrorWithText:(NSString *)errorText {
    _hud = [[MBProgressHUD alloc] initWithView:self.view];
	[self.view addSubview:_hud];
	
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	_hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"btn_adclose.png"]];
	_hud.yOffset = -10.f;
	// Set custom view mode
	_hud.mode = MBProgressHUDModeCustomView;
	
	_hud.delegate = self;
	_hud.labelText = errorText;
	
	[_hud show:YES];
	[_hud hide:YES afterDelay:2];
}

- (void)showWithText:(NSString *)text
{
    _hud = [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
	
	// Configure for text only and offset down
	_hud.mode = MBProgressHUDModeText;
	_hud.labelText = text;
	_hud.margin = 20.f;
	_hud.yOffset = 0.f;
	_hud.removeFromSuperViewOnHide = YES;
	
	[_hud hide:YES afterDelay:2];
}

- (void)hideLoading {
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[self.hud removeFromSuperview];

	self.hud = nil;
}

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorRGB(235, 235, 235);
#if defined(__IPHONE_7_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0
    
    //修复iOS7系统下布局从（0，0）开始问题
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    if ([self respondsToSelector:@selector(setExtendedLayoutIncludesOpaqueBars:)]) {
        self.extendedLayoutIncludesOpaqueBars = NO;
    }
    //    if ([self respondsToSelector:@selector(setModalPresentationCapturesStatusBarAppearance:)]) {
    //        self.modalPresentationCapturesStatusBarAppearance = NO;
    //    }
    if ([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
#endif
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self setControlView:self.view];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.baseRequest clearDelegatesAndCancel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

@end
