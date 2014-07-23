//
//  HTHomeViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//



//  测试
#import "HTHomeViewController.h"

#import "HTHomeTableViewCell.h"
#import "HTHomeHeadView.h"

@interface HTHomeViewController ()

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;




@end

@implementation HTHomeViewController

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
    CGRect rect = self.tableView.frame;
    self.tableView.frame = CGRectMake(rect.origin.x, rect.origin.y+44, rect.size.width, rect.size.height);
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
