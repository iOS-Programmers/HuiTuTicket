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
//    [self showLoadingWithText:kLOADING_TEXT];
//    __block HTHomeViewController *weak_self = self;
//    [self.scenicListHttp getDataWithCompletionBlock:^{
//        [weak_self hideLoading];
//        if (weak_self.scenicListHttp.isValid) {
//            weak_self.dataSource = weak_self.scenicListHttp.resultModel.info;
//            [weak_self.tableView reloadData];
//        }
//        else {
//            //显示服务端返回的错误提示
//            [weak_self showErrorWithText:weak_self.scenicListHttp.erorMessage];
//        };
//    }failedBlock:^{
//        [weak_self hideLoading];
//        if (![HTFoundationCommon networkDetect]) {
//            
//            [weak_self showErrorWithText:kNETWORK_ERROR];
//        }
//        else {
//            
//            //统统归纳为服务器出错
//            [weak_self showErrorWithText:kSERVICE_ERROR];
//        };
//    }];
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
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark  -
#pragma mark  - TableView Delegate
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    [self pushViewController:@"HTAppointmentViewController"];
    HTAppointmentViewController *app = [[HTAppointmentViewController alloc] init];
    [self.navigationController pushViewController:app animated:YES];
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HTHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTHomeTableViewCell" owner:self options:nil];
        for (id oneObject in cellNib)
        {
            if ([oneObject isKindOfClass:[HTHomeTableViewCell class]])
            {
                cell = (HTHomeTableViewCell *)oneObject;
            }
        }
    }


    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


@end
