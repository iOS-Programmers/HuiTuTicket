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

@interface HTEntranceTicketController ()

@end

@implementation HTEntranceTicketController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"景区门票";
    }
    return self;
}

#pragma mark - DataSource

- (void)loadDataSource
{
    self.dataSource = [NSMutableArray arrayWithArray:@[@"1",@"2",@"1",@"1",@"1"]];
    
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    HTHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTHomeTableViewCell" owner:self options:nil] lastObject];
    }
    
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
