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

#import "ScenicListHttp.h"
#import "UIImageView+WebCache.h"
#import "HTScenicDetailViewController.h"

@interface HTHomeViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) ScenicListHttp *scenicListHttp;



@end

@implementation HTHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.scenicListHttp = [[ScenicListHttp alloc] init];
    }
    return self;
}

#pragma mark - DataSource

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
    CGRect rect = self.tableView.frame;
    self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y + 2, rect.size.width, rect.size.height -2);
    HTHomeHeadView *headView =[[[NSBundle mainBundle] loadNibNamed:@"HTHomeHeadView" owner:self options:Nil] objectAtIndex:0];
    self.tableView.tableHeaderView = headView;

    
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
    HTScenicDetailViewController *app = [[HTScenicDetailViewController alloc] init];
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
    cell.levelLabel.text = scenic.rank;
    cell.placeLabel.text = scenic.address;
    cell.priceLabel.text = scenic.minprice;
    cell.oriPriceLabel.text = scenic.price;
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
