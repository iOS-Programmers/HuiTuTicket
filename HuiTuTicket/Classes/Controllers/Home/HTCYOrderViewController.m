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
@interface HTCYOrderViewController ()


@property (weak, nonatomic) IBOutlet UIView *sectionBar;




@end

@implementation HTCYOrderViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"联票景区";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.sectionBar.layer.borderWidth = 1;
    self.sectionBar.layer.borderColor = [[UIColor lightGrayColor] CGColor];

    CGRect rect = self.tableView.frame;
    self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y+88, rect.size.width, rect.size.height - 88);
    // Do any additional setup after loading the view from its nib.
}


//- (void)loadDataSource
//{
//    self.scenicListHttp.parameter.page = @"1";
//    self.scenicListHttp.parameter.pagesize = @"10";
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
//}

#pragma mark  -
#pragma mark  - TableView Delegate
- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [atableView deselectRowAtIndexPath:indexPath animated:YES];
    HTOrderDetailViewController *vc = [[HTOrderDetailViewController alloc] initWithNibName:@"HTOrderDetailViewController" bundle:Nil];
    [self.navigationController pushViewController:vc animated:YES];
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
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

@end
