//
//  HTEntranceTicketController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-25.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTEntranceTicketController.h"
#import "HTHomeTableViewCell.h"
#import "HTScenicDetailViewController.h"
#import "ScenicListHttp.h"
#import "HTModelSelVC.h"

@interface HTEntranceTicketController ()
@property (nonatomic,retain)ScenicListHttp *scenicListHttp;
@property (weak, nonatomic) IBOutlet UIView *sectionBar;


@property (weak, nonatomic) IBOutlet UIView *filterView;

- (IBAction)orderSelAction:(id)sender;
- (IBAction)areaSelAction:(id)sender;
- (IBAction)rangeSelAction:(id)sender;



@end

@implementation HTEntranceTicketController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"景区门票";
        self.scenicListHttp = [[ScenicListHttp alloc] init];
    }
    return self;
}

#pragma mark - DataSource

- (void)loadDataSource
{
//    self.scenicListHttp.parameter.cityid = @"410101";
//    self.scenicListHttp.parameter.keyword = @"";
//    self.scenicListHttp.parameter.rank = @"";
    self.scenicListHttp.parameter.page = @"1";
//    self.scenicListHttp.parameter.pagesize = @"10";
//    self.scenicListHttp.parameter.orderby = @"";
//    self.scenicListHttp.parameter.format = @"json";


    [self showLoadingWithText:kLOADING_TEXT];
    __block HTEntranceTicketController *weak_self = self;
    [self.scenicListHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.scenicListHttp.isValid) {
            weak_self.dataSource = weak_self.scenicListHttp.resultModel.info;
            [weak_self.tableView reloadData];
        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.scenicListHttp.erorMessage];
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

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!self.dataSource.count)
        [self loadDataSource];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.filterView.layer.borderWidth = 1;
    self.filterView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.tableView.rowHeight = 70;
    self.tableView.tableHeaderView = self.filterView;
    self.sectionBar.layer.borderWidth = 1;
    self.sectionBar.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    HTHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTHomeTableViewCell" owner:self options:nil] lastObject];
    }
//    TicketModel *model = [self.dataSource objectAtIndex:indexPath.row];
//    cell.nameLabel.text = model.ticketName;
//    cell.priceLabel.text = model.bookprice;
//    cell.placeLabel.text = model.state;
//    cell.oriPriceLabel.text = model.price;

    Scenic *scenic = [self.dataSource objectAtIndex:indexPath.row];
    [cell.sceneIV setImageWithURL:[NSURL URLWithString:scenic.picture]];
    cell.nameLabel.text = scenic.scenicName;
    cell.levelLabel.text = scenic.rank;
    cell.placeLabel.text = scenic.address;
    cell.priceLabel.text = scenic.minprice;
    cell.oriPriceLabel.text = scenic.price;
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Scenic *scenic = [self.dataSource objectAtIndex:indexPath.row];
    HTScenicDetailViewController *app = [[HTScenicDetailViewController alloc] init];
    app.hidesBottomBarWhenPushed = YES;
    app.scenicId = scenic.scenicId;
    [self.navigationController pushViewController:app animated:YES];
}

#pragma mark -
#pragma mark - Action
- (IBAction)orderSelAction:(id)sender
{
    HTModelSelVC *vc = [[HTModelSelVC alloc] initWithNibName:@"HTModelSelVC" bundle:nil];
    [self.view addSubview:vc.view];
}

- (IBAction)areaSelAction:(id)sender
{
    HTModelSelVC *vc = [[HTModelSelVC alloc] initWithNibName:@"HTModelSelVC" bundle:nil];
    [self presentViewController:vc animated:YES completion:^{}];
}

- (IBAction)rangeSelAction:(id)sender
{
    HTModelSelVC *vc = [[HTModelSelVC alloc] initWithNibName:@"HTModelSelVC" bundle:nil];
    [self presentViewController:vc animated:YES completion:^{}];
}
@end
