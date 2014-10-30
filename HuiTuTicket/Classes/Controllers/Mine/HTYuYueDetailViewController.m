//
//  HTYuYueDetailViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTYuYueDetailViewController.h"
#import "TicketYuYueDetailHttp.h"
#import "HTCustomDateCell.h"
#import "HTCustomMapCell.h"
#import "LPTicketOrderDetail.h"
#import "TicketYuyueCancelHttp.h"
#import "TicketYuyueChangeDateHttp.h"

#define HTDATA_ARRAY @[@{@"游览景区":@[@"景区名称",@"景区等级",@"优惠方式",@"游览限时",@"景区地址"]},@{@"游览日期":@[@"选择日期"]},@{@"预约人":@[@"联票号码",@"注册人",@"证件号码"]}]


@interface HTYuYueDetailViewController ()

@property (strong, nonatomic) TicketYuYueDetailHttp *orderListHttp;
@property (strong, nonatomic) TicketYuyueChangeDateHttp *changeDateHttp;
@property (strong, nonatomic) TicketYuyueCancelHttp *yuyueCancelHttp;


@property (strong, nonatomic) UIDatePicker *datePicker;
@property (strong, nonatomic) UIToolbar *toolBar;

//点击更改日期后才会赋值
@property (copy, nonatomic) NSString *yuyueDateString;

@end

@implementation HTYuYueDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"预约详情";
        _orderListHttp = [[TicketYuYueDetailHttp alloc] init];
        _changeDateHttp = [[TicketYuyueChangeDateHttp alloc] init];
        _yuyueCancelHttp = [[TicketYuyueCancelHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self requesDetailData];
    self.tableView.tableFooterView = [self footerView];
    
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 *  表格底部的footerview
 *
 *  @return
 */
- (UIView *)footerView
{
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    footView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];;
    footView.layer.borderWidth = 1;
    footView.layer.borderColor = [UIColorRGB(235, 235, 235) CGColor];
    
    //取消预约按钮
    UIButton *cancelYuyueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelYuyueBtn.backgroundColor = [UIColor purpleColor];
    cancelYuyueBtn.frame = CGRectMake(10, 8, 90, 37);
    [cancelYuyueBtn setTitle:@"取消预约" forState:UIControlStateNormal];
    cancelYuyueBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [cancelYuyueBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelYuyueBtn addTarget:self action:@selector(cancelYuyueBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:cancelYuyueBtn];
    
    //更改游览日期按钮
    UIButton *changeDateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeDateBtn.backgroundColor = [UIColor orangeColor];
    changeDateBtn.frame = CGRectMake(110, 8, 180, 37);
    [changeDateBtn setTitle:@"更改游览日期" forState:UIControlStateNormal];
    changeDateBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    [changeDateBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [changeDateBtn addTarget:self action:@selector(changetravelDate) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:changeDateBtn];
    
    return footView;
}

#pragma mark - Action
- (void)requesDetailData
{
    
    if (self.yuyueinfo) {
        self.orderListHttp.parameter.codenumber = self.yuyueinfo.codeNumber;
        self.orderListHttp.parameter.orderid = self.yuyueinfo.orderid;
    }
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTYuYueDetailViewController *weak_self = self;
    [self.orderListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.orderListHttp.isValid) {
            
            [weak_self updateUIWithDetailData:weak_self.orderListHttp.resultModel];
            LXLog(@"%@",weak_self.orderListHttp.resultModel);
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.orderListHttp.erorMessage];
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



- (void)updateUIWithDetailData:(TicketYuYueDetail*)detail
{
    detail.timelimit = [detail.timelimit isEqualToString:@"0"] ? @"不限时":@"限时游览";
    detail.ptype = [detail.ptype isEqualToString:@"0"] ? @"免票":@"优惠";
    
    //判断星级
    NSArray *tempArr = @[@"A",@"AA",@"AAA",@"AAAA",@"AAAAA"];
    if ([detail.rank integerValue] > 0 && [detail.rank integerValue] < 6) {
        detail.rank = tempArr[[detail.rank integerValue] - 1];
    }
    else {
        detail.rank = @"";
    }
    
    
    //组装数组
    NSMutableArray *dataArr = [[NSMutableArray alloc] initWithCapacity:3];
    [dataArr addObject:@{@"游览景区": @[detail.scenicName,detail.rank,detail.ptype,detail.timelimit,detail.address]}];
    [dataArr addObject:@{@"游览日期": @[detail.traveltime]}];
    [dataArr addObject:@{@"预约人": @[detail.codeNumber,detail.username,detail.idcard]}];
    
    self.dataSource = dataArr;
    
    [self.tableView reloadData];
}

/**
 *  取消预约
 */
- (void)cancelYuyueBtnClicked
{

    if (self.yuyueinfo) {
        self.yuyueCancelHttp.parameter.codenumber = self.yuyueinfo.codeNumber;
        self.yuyueCancelHttp.parameter.orderid = self.yuyueinfo.orderid;
    }
    
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTYuYueDetailViewController *weak_self = self;
    [self.yuyueCancelHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.yuyueCancelHttp.isValid) {
            
            LXLog(@"%@",weak_self.yuyueCancelHttp.resultModel);
            
            LXLog(@"%@",weak_self.changeDateHttp.resultModel);
            [weak_self showWithText:@"取消成功"];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //[weak_self.navigationController popViewControllerAnimated:YES];
            });
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.yuyueCancelHttp.erorMessage];
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

/**
 *  更改游览日期
 */
- (void)changetravelDate
{
    //
    if (self.yuyueinfo && !FBIsEmpty(self.yuyueDateString)) {
        self.changeDateHttp.parameter.codenumber = self.yuyueinfo.codeNumber;
        self.changeDateHttp.parameter.orderid = self.yuyueinfo.orderid;
        self.changeDateHttp.parameter.time = self.yuyueDateString;
        
        [self showLoadingWithText:kLOADING_TEXT];
        __block HTYuYueDetailViewController *weak_self = self;
        [self.changeDateHttp getDataWithCompletionBlock:^{
            [weak_self hideLoading];
            
            if (weak_self.changeDateHttp.isValid) {
                
                LXLog(@"%@",weak_self.changeDateHttp.resultModel);
                [weak_self showWithText:@"更改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weak_self.navigationController popViewControllerAnimated:YES];
                });
            }
            else {
                //显示服务端返回的错误提示
                [weak_self showErrorWithText:weak_self.changeDateHttp.erorMessage];
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
    
    
}


/**
 *  点击更改日期按钮
 *
 *  @param sender
 */
- (IBAction)onChangeDateBtnClick:(id)sender
{
    [self showPickerView];
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

-(void)dateChanged:(id)sender{
    UIDatePicker *control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateAndTime =  [dateFormatter stringFromDate:_date];
    
    self.yuyueDateString = dateAndTime;
    
    /**
     *  刷新表格去更改cell上的title
     */
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [HTDATA_ARRAY count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [[[HTDATA_ARRAY objectAtIndex:section] allValues]objectAtIndex:0];
    return [array  count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = [[HTDATA_ARRAY objectAtIndex:section] allKeys];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    headView.layer.borderWidth = 1;
    headView.layer.borderColor = [UIColorRGB(235, 235, 235) CGColor];
    headView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 3, 100, 17)];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = [array objectAtIndex:0];
    [headView addSubview:label];
    return headView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    if (indexPath.section==1&&indexPath.row==0)
    {
        HTCustomDateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTCustomDateCell" owner:self options:nil];
            for (id oneObject in cellNib)
            {
                if ([oneObject isKindOfClass:[HTCustomDateCell class]])
                {
                    cell = (HTCustomDateCell *)oneObject;
                }
            }
        }
        
        NSArray *array = [[[HTDATA_ARRAY objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
        cell.leftLB.text = [array objectAtIndex:indexPath.row];
        if ([self.dataSource count] != 0) {
            
            NSArray *dataArray = [[[self.dataSource objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
            [cell.dateSelBtn setTitle:[dataArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
            
            //每次更改日期后，刷新表格，刷新按钮的title
            if (self.yuyueDateString && [self.yuyueDateString length] > 1) {
                [cell.dateSelBtn setTitle:self.yuyueDateString forState:UIControlStateNormal];
            }
            
            [cell.dateSelBtn addTarget:self action:@selector(onChangeDateBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        return cell;
    }
    else
    {
        HTCustomMapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTCustomMapCell" owner:self options:nil];
            for (id oneObject in cellNib)
            {
                if ([oneObject isKindOfClass:[HTCustomMapCell class]])
                {
                    cell = (HTCustomMapCell *)oneObject;
                }
            }
        }

        NSArray *array = [[[HTDATA_ARRAY objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
        cell.leftLabel.text = [array objectAtIndex:indexPath.row];
        if ([self.dataSource count] != 0) {
            NSArray *dataArray = [[[self.dataSource objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
            
            cell.rightLabel.text = [dataArray objectAtIndex:indexPath.row];
        }
        
        return cell;
    }
}



@end
