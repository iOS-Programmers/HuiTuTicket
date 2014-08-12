//
//  HTTicketDetailController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTicketDetailController.h"
#import "HTTicketDetailCell.h"
#import "TicketDetailHttp.h"

@interface HTTicketDetailController ()

@property (strong, nonatomic) TicketDetailHttp *detailHttp;

@property (strong, nonatomic) NSMutableArray *titles;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)segementChanged:(id)sender;
@end

@implementation HTTicketDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"联票详情";
        
        _detailHttp = [[TicketDetailHttp alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView setContentSize:CGSizeMake(640, 500)];

    [self requestDetailData];
    
    self.titles = [self titleArray];
}

- (NSMutableArray *)titleArray
{
    NSMutableArray *titileArray = [[NSMutableArray alloc] initWithCapacity:0];
    [titileArray addObject:@[@"联票号码",@"注册人",@"证件号码",@"有效期至",@"注册时间"]];
    [titileArray addObject:@[@"产品名称",@"景区数量"]];
    
    return titileArray;
}

- (void)requestDetailData
{
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTTicketDetailController *weak_self = self;
    
    self.detailHttp.parameter.typeid = @"5";
    
    [self.detailHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        
        if (weak_self.detailHttp.isValid) {
            [weak_self showWithText:@"联票详情请求成功"];
//            weak_self.dataSource = weak_self.detailHttp.resultModel.info;
            [weak_self.tableView reloadData];
            
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.detailHttp.erorMessage];
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

- (IBAction)segementChanged:(id)sender
{
    UISegmentedControl *segement = (UISegmentedControl *)sender;

    switch (segement.selectedSegmentIndex) {
        case 0:
        {
            //联票详情
            [self.scrollView setContentOffset:CGPointMake(0, 0)];
        }
            break;
        case 1:
        {
            //二维码
            [self.scrollView setContentOffset:CGPointMake(320, 0)];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.titles count];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titles[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"detailCell";
//
    HTTicketDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTicketDetailCell" owner:self options:nil] lastObject];
    }
    
    NSArray *titleArr = self.titles[indexPath.section];
    cell.titleLabel.text = titleArr[indexPath.row];
    
    

    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

@end
