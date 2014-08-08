//
//  HTOrderResultViewController.m
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-8.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTOrderResultViewController.h"
#import "HTHomeTableViewCell.h"

@interface HTOrderResultViewController ()

@property (nonatomic, strong) IBOutlet UIView *headView;

@end

@implementation HTOrderResultViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"提交成功";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self refreshUIShow];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - custom
- (void)refreshUIShow
{
    self.view.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = self.headView;
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
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
