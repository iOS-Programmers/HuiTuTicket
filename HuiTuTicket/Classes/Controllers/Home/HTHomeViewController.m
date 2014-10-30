//
//  HTHomeViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//




#import "HTHomeViewController.h"
#import "HTAppointmentViewController.h"
#import "HTHomeTableViewCell.h"
#import "HTHomeHeadView.h"

#import "ZBarSDK.h"
#import "HTSaoMiaoLPTicketDetailVC.h"

#import "ScenicListHttp.h"
#import "UIImageView+WebCache.h"
#import "HTHomeDetailSceneVC.h"
#import "HomeBannerHttp.h"

@interface HTHomeViewController ()<ZBarReaderDelegate>
{
    HTHomeHeadView *headView;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) ScenicListHttp *scenicListHttp;

@property (strong, nonatomic) HomeBannerHttp *homeBannerHttp;


@end

@implementation HTHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.scenicListHttp = [[ScenicListHttp alloc] init];
        self.homeBannerHttp = [[HomeBannerHttp alloc] init];

    }
    return self;
}

#pragma mark - DataSource
- (void)loadBanner
{
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTHomeViewController *weak_self = self;
    [self.homeBannerHttp getDataWithCompletionBlock:^{
        [weak_self hideLoading];
        if (weak_self.homeBannerHttp.isValid) {
            
            [weak_self updateBannerUI:weak_self.homeBannerHttp.resultModel.dataArray];

        }
        else {
            //显示服务端返回的错误提示
            [weak_self showErrorWithText:weak_self.homeBannerHttp.erorMessage];
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

- (void)updateBannerUI:(NSMutableArray *)array
{
    if ([array count] == 0) {
        return;
    }
    
    Banner *bannerInfo = (Banner *)array[0];
    [headView.bannerImage setImageWithURL:[NSURL URLWithString:bannerInfo.image]];
}

- (void)loadDataSource
{
    self.scenicListHttp.parameter.page = @"1";
    self.scenicListHttp.parameter.pagesize = @"10";
    [self showLoadingWithText:kLOADING_TEXT];
    __block HTHomeViewController *weak_self = self;
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
    
    self.canPullRefresh = YES;
    
    CGRect rect = self.tableView.frame;
    self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y + 2, rect.size.width, rect.size.height -2);
    headView =[[[NSBundle mainBundle] loadNibNamed:@"HTHomeHeadView" owner:self options:Nil] objectAtIndex:0];
    self.tableView.tableHeaderView = headView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self loadBanner];
    
    self.navigationItem.leftBarButtonItem = [self leftNavItem];
    self.navigationItem.rightBarButtonItem = [self rightNavItem];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Aciton

- (void)leftItemClick
{
    //打电话
    UIWebView *web = [[UIWebView alloc] init];
    
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",SERVICE_NUMBER]]]];
    [self.view addSubview:web];
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


- (UIBarButtonItem *)leftNavItem
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0f, 0.0f, 35, 35);
    btn.backgroundColor = [UIColor clearColor];
    [btn setImage:[UIImage imageNamed:@"home_phone_icon"] forState:UIControlStateNormal];
    btn.showsTouchWhenHighlighted = YES;
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [btn addTarget:self action:@selector(leftItemClick) forControlEvents:UIControlEventTouchUpInside];
    [btn showsTouchWhenHighlighted];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return item;
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


#pragma mark  -
#pragma mark  - TableView Delegate
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    Scenic *scenic = [self.dataSource objectAtIndex:indexPath.row];
    HTHomeDetailSceneVC *app = [[HTHomeDetailSceneVC alloc] init];
    app.hidesBottomBarWhenPushed = YES;
    app.scenicId = scenic.scenicId;
    [self.navigationController pushViewController:app animated:YES];
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scenicListHttp.resultModel.info count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    HTHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTHomeTableViewCell" owner:self options:nil] lastObject];
    }
    Scenic *scenic = [self.dataSource objectAtIndex:indexPath.row];
   
    [cell.sceneIV setImageWithURL:[NSURL URLWithString:scenic.picture]];
    cell.nameLabel.text = scenic.scenicName;
    cell.levelLabel.text = [self stringChangeToStar:scenic.rank];
    cell.provinceLab.text = scenic.province;
    
    cell.placeLabel.text = scenic.city;
    
    cell.priceLabel.text = scenic.minprice;
    //cell.oriPriceLabel.text = scenic.price;
    cell.oldPriceLab.text = scenic.price;
    return cell;
}

- (NSString *)stringChangeToStar:(NSString *)level
{
    NSString *star = @"";
    
    if ([level isEqualToString:@"0"]) {
        level = @"0";
    }
    if ([level intValue] > 5) {
        level = @"5";
    }
    
    NSMutableArray * array = [[NSMutableArray alloc] initWithCapacity:4];
    [array addObjectsFromArray:@[@"未评定",@"A",@"AA",@"AAA",@"AAAA",@"AAAAA"]];
    
    star = array[[level intValue]];
    
    return star;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
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
        //扫描到联票号码，进入联票详情资料页
        HTSaoMiaoLPTicketDetailVC *saomiao = [[HTSaoMiaoLPTicketDetailVC alloc] init];
        saomiao.ticketNumber = symbol.data;
        [self.navigationController pushViewController:saomiao animated:NO];
    });
}

#pragma mark 上下拉刷新的Delegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    //下拉刷新时的操作
    if (self.header == refreshView) {
        
        [self loadDataSource];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [refreshView endRefreshing];
        });
    }

}

@end
