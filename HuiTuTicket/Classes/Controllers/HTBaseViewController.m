//
//  HTBaseViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HT. All rights reserved.
//

#import "HTBaseViewController.h"
#import "MBProgressHUD.h"

@interface HTBaseViewController () <MBProgressHUDDelegate>

@property (nonatomic, strong) MBProgressHUD *hud;

@property (nonatomic, copy) HTBarButtonItemActionBlock barbuttonItemAction;

@end

@implementation HTBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
- (void)showError {
    
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
    [_hud hide:YES];
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
    self.view.backgroundColor = [UIColor whiteColor];
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
