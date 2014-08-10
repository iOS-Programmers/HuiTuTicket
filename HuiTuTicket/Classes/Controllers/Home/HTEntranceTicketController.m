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

@interface HTEntranceTicketController ()
@property (nonatomic,retain)ScenicListHttp *scenicListHttp;
@property (weak, nonatomic) IBOutlet UIView *sectionBar;

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
    self.scenicListHttp.parameter.cityid = @"410101";
//    self.scenicListHttp.parameter.keyword = @"";
//    self.scenicListHttp.parameter.rank = @"";
    self.scenicListHttp.parameter.page = @"1";
    self.scenicListHttp.parameter.pagesize = @"10";
//    self.scenicListHttp.parameter.orderby = @"";
    self.scenicListHttp.parameter.format = @"json";


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
    self.tableView.rowHeight = 70;
    
    self.sectionBar.layer.borderWidth = 1;
    self.sectionBar.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    
    CGRect rect = self.tableView.frame;
    self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y+88, rect.size.width, rect.size.height - 88);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
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

//    Scenic *scenic = [self.dataSource objectAtIndex:indexPath.row];
//    [cell.sceneIV setImageWithURL:[NSURL URLWithString:scenic.picture]];
//    cell.nameLabel.text = scenic.scenicName;
//    cell.levelLabel.text = scenic.rank;
//    cell.placeLabel.text = scenic.address;
//    cell.priceLabel.text = scenic.minprice;
//    cell.oriPriceLabel.text = scenic.price;
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HTScenicDetailViewController *app = [[HTScenicDetailViewController alloc] init];
    [self.navigationController pushViewController:app animated:YES];
}

@end
