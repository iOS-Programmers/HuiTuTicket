//
//  HTTaoPiaoYuDingController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/10/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaoPiaoYuDingController.h"

#import "TPOrderSubmitHttp.h"

#import "HTTaopiaoYuDingCell.h"

#import "TaoPiaoScenicInfo.h"

#import "TaoPiaoTicket.h"
#define DATEPICKER_HEIGHT 216

@interface HTTaoPiaoYuDingController ()

@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (strong, nonatomic) IBOutlet UIView *tableFootView;

@property (weak, nonatomic) IBOutlet UILabel *totoalPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *payBtn;

@property (weak, nonatomic) IBOutlet UILabel *ticketName;

@property (weak, nonatomic) IBOutlet UILabel *ticketNumLabel;

@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (nonatomic,strong)UIDatePicker *datePicker;
@property (nonatomic,strong)UIToolbar *toolBar;
@property (nonatomic,copy)NSString *selDate;
@property (nonatomic,copy)NSString *currID;

@property (strong, nonatomic) TPOrderSubmitHttp *submitHttp;

@property (nonatomic,strong)NSMutableDictionary *dataDic;

- (IBAction)onPayBtnClick:(id)sender;
- (IBAction)onPlusAction:(UIButton *)sender;
- (IBAction)onMinAction:(UIButton *)sender;

@end

@implementation HTTaoPiaoYuDingController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"填写订单";
        _submitHttp = [[TPOrderSubmitHttp alloc] init];
        _dataDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 88;
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.tableFooterView = self.tableFootView;
    [self.tableView frameSetHeight:[HTFoundationCommon getScreenHeight] + 20];
    self.tableView.clipsToBounds = YES;
    
    [self dateSelectorInit];
    [self updateUIWithInfo];
    [self shuchuViewFrame];
}

- (void)shuchuViewFrame
{
    for (int i=0; i<[self.view.subviews count]; i++)
    {
        UIView *aview = [self.view.subviews objectAtIndex:i];
        NSLog(@"%@:%@",[aview class],NSStringFromCGRect(aview.frame));
        for (int j=0; j<[aview.subviews count]; j++)
        {
            UIView *bview = [aview.subviews objectAtIndex:j];
            NSLog(@"%@:%@",[bview class],NSStringFromCGRect(bview.frame));
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)getTime
{
    NSString *str = @"";
    for (int i = 0; i<[[self.dataDic allKeys] count]; i++)
    {
        NSString *key = [[self.dataDic allKeys] objectAtIndex:i];
        if (i==0)
        {
            str = [NSString stringWithFormat:@"%@|%@",key,[self.dataDic objectForKey:key]];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@,%@|%@",str,key,[self.dataDic objectForKey:key]];
        }
    }
    return str;
}

- (NSString *)getScenicid
{
    NSString *str = @"";
    for (int i = 0; i<[self.productInfo.scenicinfo count]; i++)
    {
        TaoPiaoScenicInfo *info = [[self.dataDic allKeys] objectAtIndex:i];
        if (i==0)
        {
            str = [NSString stringWithFormat:@"%@",info.scenicId];
        }
        else
        {
            str = [NSString stringWithFormat:@"%@,%@",str,info.scenicId];
        }
    }
    return str;
}

- (NSString *)getTicketId
{
    NSString *str = @"";
    for (int i = 0; i<[self.productInfo.scenicinfo count]; i++)
    {
        TaoPiaoScenicInfo *info = [[self.dataDic allKeys] objectAtIndex:i];
        for (int j=0; j<[info.ticket count]; j++)
        {
            TaoPiaoTicket *ticket= info.ticket[j];
            if ([str length]==0)
            {
                str = [NSString stringWithFormat:@"%@",ticket.ticketId];
            }
            else
            {
                str = [NSString stringWithFormat:@"%@,%@",str,ticket.ticketId];
            }
        }
    }
    return str;
}

- (void)dateSelectorInit
{
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height + 44, 320, DATEPICKER_HEIGHT)];
    
    if (IOS7_OR_LATER) {
        [_datePicker setBackgroundColor:kColorWhite];
    }
    
    [_datePicker setTimeZone:[NSTimeZone systemTimeZone]];
    [_datePicker setDate:[NSDate date] animated:YES];
    [_datePicker setMinimumDate:[NSDate date]];
    [_datePicker setDatePickerMode:UIDatePickerModeDate];
    [_datePicker addTarget:self action:@selector(datePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_datePicker];
    
    _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, [LXUtils GetScreeHeight]-44, [LXUtils GetScreeWidth], 44)];
    _toolBar.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    LXLog(@"SEE %@",NSStringFromCGRect(self.view.frame));
    
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    UIBarButtonItem *myDoneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                  target:self
                                                                                  action:@selector(dateFinished)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [buttons addObject:flexibleSpace];
    [buttons addObject: myDoneButton];
    [self.toolBar setItems:buttons animated:TRUE];
    [self.view addSubview:_toolBar];
}

- (void)showDateSelector
{
    [self.view bringSubviewToFront:self.toolBar];
    [self.view bringSubviewToFront:self.datePicker];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height - DATEPICKER_HEIGHT-44, 320, 44);
    self.datePicker.frame = CGRectMake(0, self.view.frame.size.height - DATEPICKER_HEIGHT, 320, DATEPICKER_HEIGHT);
    [UIView commitAnimations];
}

- (void)datePickerValueChanged:(id)sender
{
    NSDate *select = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectedDate = [dateFormatter stringFromDate:select];
    self.selDate =selectedDate;
}

- (void)dateFinished
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selectedDate = [dateFormatter stringFromDate:[NSDate date]];
    [self.dataDic setObject:FBIsEmpty(self.selDate)?selectedDate:self.selDate forKey:self.currID];
    [self hideDatePicker];
    [self.tableView reloadData];
}

-(void)hideDatePicker
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.toolBar.frame = CGRectMake(0, self.view.frame.size.height, 320, 44);
    self.datePicker.frame = CGRectMake(0, self.view.frame.size.height+44, 320, DATEPICKER_HEIGHT);
    [UIView commitAnimations];
}

- (void)submitOrder
{
//    校验串生成方法：将请求参数中的uid、scenicid、ticketid、number、travel_time、receive_moblie、key七个参数的value值拼成一个无间隔的字符串(顺序不要改变)，key是参数签名密钥。
//    MD5字符串示例：
//    106201307011536259678253012013-07-1613800138000key


    if ([[self.dataDic allKeys] count]==[self.productInfo.scenicinfo count])
    {
        self.submitHttp.parameter.travel_time = [self getTime];

        self.submitHttp.parameter.tpid = self.productInfo.tpid;
        self.submitHttp.parameter.number = self.ticketNumLabel.text;
        self.submitHttp.parameter.receive_name = self.userNameTF.text;
        self.submitHttp.parameter.receive_moblie = self.phoneTF.text;
        
         NSString *strUnMd5= [NSString stringWithFormat:@"%@%@%@%@%@%@%@",[[HTUserInfoManager shareInfoManager] userId],[self getScenicid],[self getTicketId],self.ticketNumLabel.text,[self getTime],self.phoneTF.text,API_KEY];
        self.submitHttp.parameter.sig = [HTFoundationCommon md5:strUnMd5];
        [self showLoadingWithText:kLOADING_TEXT];
        __weak HTTaoPiaoYuDingController *weak_self = self;
        [self.submitHttp getDataWithCompletionBlock:^{
            [weak_self hideLoading];
            if (weak_self.submitHttp.isValid) {
            
                [weak_self showSuccess];
                
                
            }
            else {
                //显示服务端返回的错误提示
                [weak_self showErrorWithText:weak_self.submitHttp.erorMessage];
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
    else
    {
        [self showErrorWithText:@"请选择出行日期"];
    }
}

#pragma mark - Action

- (void)updateUIWithInfo
{
    if (self.productInfo) {
        self.ticketName.text = self.productInfo.title;
        
        if ([self.productInfo.scenicinfo count] > 0) {
            self.dataSource = self.productInfo.scenicinfo;
            [self.tableView reloadData];
        }
    }
}

- (IBAction)onPayBtnClick:(id)sender {
    [self submitOrder];
}

- (IBAction)onPlusAction:(UIButton *)sender
{
    int count = [self.ticketNumLabel.text intValue];
    self.ticketNumLabel.text = [NSString stringWithFormat:@"%d",count+1];
}

- (IBAction)onMinAction:(UIButton *)sender
{
    int count = [self.ticketNumLabel.text intValue];
    if (count!=0)
    {
        self.ticketNumLabel.text = [NSString stringWithFormat:@"%d",count-1];
    }
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaoPiaoScenicInfo *info = (TaoPiaoScenicInfo *)self.dataSource[indexPath.row];
    self.currID = info.scenicId;
    [self showDateSelector];
}
#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentfier";
    
    HTTaopiaoYuDingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTaopiaoYuDingCell" owner:self options:nil] lastObject];
    }
    
    TaoPiaoScenicInfo *info = (TaoPiaoScenicInfo *)self.dataSource[indexPath.row];
    if ([info.ticket count] > 0) {
        TaoPiaoTicket *ticket = (TaoPiaoTicket *)info.ticket[0];
        cell.ticketNumLabel.text = [NSString stringWithFormat:@"%@张",ticket.num];
        cell.ticketTypeLabel.text = [NSString stringWithFormat:@"%@",ticket.ticketName];
        NSString *str = [self.dataDic objectForKey:info.scenicId];
        if (FBIsEmpty(str))
        {
            str = @"请选择出行日期";
        }
        [cell.travelDateBtn setTitle:str forState:UIControlStateNormal];
    }
    
    cell.scenicName.text = info.scenicName;
    
    
    return cell;
}
@end
