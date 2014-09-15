//
//  HTOrderViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTOrderViewController.h"
#import "HTScenicOrderListViewController.h"
#import "HTTaopiaoOrderController.h"
#import "HTStoreManager.h"
@interface HTOrderViewController ()

@end

@implementation HTOrderViewController

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
    self.dataSource = [[HTStoreManager shareStoreManager] getOrderConfigureArray];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    NSDictionary *moreDictionary = self.dataSource[indexPath.section];
    cell.imageView.image = [UIImage imageNamed:[moreDictionary valueForKey:@"image"][indexPath.row]];
    cell.textLabel.text = [moreDictionary valueForKey:@"title"][indexPath.row];

    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController;
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    switch (section) {
        case 1: {
            switch (row) {
                case 0:
                {
                    HTScenicOrderListViewController *order = [[HTScenicOrderListViewController alloc] init];
                    order.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:order animated:YES];
                }
                    break;
                case 1: {
                    HTTaopiaoOrderController *taopiao = [[HTTaopiaoOrderController alloc] init];
                    taopiao.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:taopiao animated:YES];
                }
                    break;
                    
                default:
                    [self showWithText:@"该功能暂未开发，尽请期待！"];
                    break;
            }
        }
            break;
            
        default: {
            //只有景区门票订单可用，其他的点击提示该功能暂未开发，尽请期待。
            [self showWithText:@"该功能暂未开发，尽请期待！"];
        }
            break;
    }
    if (viewController) {
        [self pushNewViewController:viewController];
    }
}

@end
