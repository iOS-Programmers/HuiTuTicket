//
//  HTCYOrderViewController.m
//  HuiTuTicket
//
//  Created by Bird on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTCYOrderViewController.h"
#import "HTOrderTableViewCell.h"
#import "HTOrderDetailViewController.h"

#import "TicketYuyueScenicListHttp.h"
#import "MyTicketDetailInfo.h"
#import "TicketScenicSpot.h"

@interface HTCYOrderViewController ()


@property (weak, nonatomic) IBOutlet UIView *sectionBar;
@property (strong, nonatomic) TicketYuyueScenicListHttp  *yuyueHttp;



@end

@implementation HTCYOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"联票景区";
        _yuyueHttp = [[TicketYuyueScenicListHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sectionBar.layer.borderWidth = 1;
    self.sectionBar.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    CGRect rect = self.tableView.frame;
    self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y+44, rect.size.width, rect.size.height - 44);
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadDataSource];
}

- (void)loadDataSource
{
    if (self.ticketdetail) {
        self.yuyueHttp.parameter.username = self.ticketdetail.username;
        self.yuyueHttp.parameter.codenumber = self.ticketdetail.codeNumber;
    }
//    self.yuyueHttp.parameter.page = @"1";
//    self.yuyueHttp.parameter.pagesize = @"10";
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTCYOrderViewController *weak_self = self;
    [self.yuyueHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.yuyueHttp.isValid) {
            weak_self.dataSource = weak_self.yuyueHttp.resultModel.info;
            [weak_self.tableView reloadData];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.yuyueHttp.erorMessage];
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

#pragma mark  -
#pragma mark  - TableView Delegate
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TicketScenicSpot *info = (TicketScenicSpot *)self.dataSource[indexPath.row];
    
    HTOrderDetailViewController *vc = [[HTOrderDetailViewController alloc] initWithNibName:@"HTOrderDetailViewController" bundle:Nil];
    
    //联票数据
    vc.ticketdetail = self.ticketdetail;
    //联票景区详情数据
    vc.scenicDetail = info;
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HTOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTOrderTableViewCell" owner:self options:nil];
        for (id oneObject in cellNib)
        {
            if ([oneObject isKindOfClass:[HTOrderTableViewCell class]])
            {
                cell = (HTOrderTableViewCell *)oneObject;
            }
        }
    }
    
    TicketScenicSpot *info = (TicketScenicSpot *)self.dataSource[indexPath.row];
    [cell.iv setImageWithURL:[NSURL URLWithString:info.picture] placeholderImage:nil];
    cell.nameLB.text = info.scenicName;
    cell.placeLB.text = info.address;
    cell.timeLB.text = [info.timelimit isEqualToString:@"0"] ? @"不限时" : @"限时游览";
    if ([info.state isEqualToString:@"1"]) {
        //正常
        [cell.orderBtn setTitle:@"预约" forState:UIControlStateNormal];
        cell.orderBtn.backgroundColor = [UIColor orangeColor];
    }
    else if ([info.state isEqualToString:@"2"]) {
        //已预约
        [cell.orderBtn setTitle:@"已预约" forState:UIControlStateNormal];
        cell.orderBtn.backgroundColor = [UIColor purpleColor];
    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

@end
