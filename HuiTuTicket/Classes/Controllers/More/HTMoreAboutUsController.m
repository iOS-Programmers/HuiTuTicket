//
//  HTMoreAboutUsController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMoreAboutUsController.h"
#import "HTAboutUSWebViewController.h"
#import "HTStoreManager.h"
@interface HTMoreAboutUsController ()

@end

@implementation HTMoreAboutUsController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"关于我们";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.dataSource = [[HTStoreManager shareStoreManager] getAboutUsConfigureArray];
    
    self.tableView.frame = CGRectMake(0, 190, 320, 152);
    self.tableView.scrollEnabled = NO;
    self.tableView.rowHeight = 44;
    self.tableView.sectionFooterHeight = 1;
    self.tableView.sectionHeaderHeight = 1;
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
    
    if (indexPath.row < self.dataSource.count) {
        cell.textLabel.text = self.dataSource[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:15];
    }
    
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *viewController;
    NSInteger row = indexPath.row;
//    NSInteger section = indexPath.section;
    switch (row) {
        case 2: {
            //关于我们
            HTAboutUSWebViewController *about = [[HTAboutUSWebViewController alloc] init];
            viewController = about;
        }
            break;
            
        default:
            break;
    }
    
    if (viewController) {
        [self pushNewViewController:viewController];
    }
    
}

@end
