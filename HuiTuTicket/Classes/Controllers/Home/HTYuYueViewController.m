//
//  HTYuYueViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTYuYueViewController.h"
#import "HTCYOrderViewController.h"
#import "ZBarSDK.h"
#import "MyTicketDetailInfo.h"

@interface HTYuYueViewController () <ZBarReaderDelegate>

@property (weak, nonatomic) IBOutlet UITextField *lpCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UIButton *dateButton;

@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *toolBar;

- (IBAction)onChangeDateBtnClick:(id)sender;

- (IBAction)onYuYueBtnClick:(id)sender;
@end

@implementation HTYuYueViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"预约";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _dateButton.layer.borderColor = kColorWhite.CGColor;
    _dateButton.layer.borderWidth = 1;
    _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height + 44, 320, 162)];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    _datePicker.backgroundColor = kColorWhite;
    [_datePicker setMinimumDate:[NSDate dateWithTimeIntervalSinceNow:1*24*60*60]];
    [_datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_datePicker];
    
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
    
    self.navigationItem.rightBarButtonItem = [self rightNavItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

#pragma mark - Action

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

- (void)hidePickerView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height, 320, 44);
    self.datePicker.frame = CGRectMake(0, self.view.frame.size.height+44, 320, 162);
    [UIView commitAnimations];
}

- (void)showPickerView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - 162-44, 320, 44);
    self.datePicker.frame = CGRectMake(0, self.view.frame.size.height - 162, 320, 162);
    [UIView commitAnimations];
}

- (IBAction)onChangeDateBtnClick:(id)sender
{
    [self showPickerView];
}

- (IBAction)onYuYueBtnClick:(id)sender
{
    if (FBIsEmpty(self.lpCodeTF.text)) {
        [self showWithText:@"请输入联票号码"];
        return;
    }
    else if (FBIsEmpty(self.nameTF.text)) {
        [self showWithText:@"请输入姓名"];
        return;
    }
    [self.view endEditing:YES];
    
    
    HTCYOrderViewController *vc = [[HTCYOrderViewController alloc] init];
    
    MyTicketDetailInfo *ticketdetail = [[MyTicketDetailInfo alloc] init];
    ticketdetail.username = self.nameTF.text;
    ticketdetail.codeNumber = self.lpCodeTF.text;
    
    vc.ticketdetail = ticketdetail;
    
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    /*添加你自己响应代码*/
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime =  [dateFormatter stringFromDate:_date];
    
    [_dateButton setTitle:dateAndTime forState:UIControlStateNormal];
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
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //扫描到联票号码，填入联票号码信息
        self.lpCodeTF.text = symbol.data;
        [self.navigationController popViewControllerAnimated:YES];
       
    });
}


@end
