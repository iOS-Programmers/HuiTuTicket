//
//  HTMineViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMineViewController.h"
#import "HTMineHeaderView.h"
#import "HTStoreManager.h"

#import "HTMyTicketController.h"
#import "HTLoginController.h"

@interface HTMineViewController ()<HTMineHeaderViewDelegate>

@end

@implementation HTMineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - DataSource

- (void)loadDataSource
{
    self.dataSource = [[HTStoreManager shareStoreManager] getMineConfigureArray];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    HTMineHeaderView *headView = [HTMineHeaderView instanceHeaderView];
    headView.delegate = self;
    headView.frame = CGRectMake(0, 0, 320, 145);
    
    self.tableView.tableHeaderView = headView;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HTMineHeadView Delegate
- (void)onLogin
{
    HTLoginController *loginVC = [[HTLoginController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    
    [self.navigationController presentViewController:nav animated:YES completion:^{
        
    }];
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentfier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    if (indexPath.row < self.dataSource.count) {
        NSDictionary *moreDictionary = self.dataSource[indexPath.section];
        cell.imageView.image = [UIImage imageNamed:[moreDictionary valueForKey:@"image"][indexPath.row]];
        cell.textLabel.text = [moreDictionary valueForKey:@"title"][indexPath.row];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController;

    NSInteger section = indexPath.section;
    switch (section) {
       case 0: {
            HTMyTicketController *myTicket = [[HTMyTicketController alloc] init];
            myTicket.hidesBottomBarWhenPushed = YES;
            viewController = myTicket;
            break;
        }
        
            
        default: {
            //只有我的联票可用，其他的点击提示该功能暂未开发，尽请期待。
            [self showWithText:@"该功能暂未开发，尽请期待！"];
        }
            break;
    }
    if (viewController) {
        [self pushNewViewController:viewController];
    }

}

#pragma mark - Action
@end
