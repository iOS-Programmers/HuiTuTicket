//
//  HTModelSelVC.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTModelSelVC.h"
#import "HTModelSelCell.h"
@interface HTModelSelVC ()
@property (nonatomic,assign)int selRow;

@property (nonatomic,strong)IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *selectTypeLB;
@property (strong, nonatomic) IBOutlet UIView *header;
@property (strong, nonatomic) IBOutlet UIView *footer;


- (IBAction)confirmAction:(id)sender;

@end

@implementation HTModelSelVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.iconIV.layer.cornerRadius = 5;
    self.iconIV.clipsToBounds = YES;
    
    self.tableView.tableHeaderView = self.header;
    self.tableView.tableFooterView = self.footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    HTModelSelCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTModelSelCell" owner:self options:nil];
        for (id oneObject in cellNib)
        {
            if ([oneObject isKindOfClass:[HTModelSelCell class]])
            {
                cell = (HTModelSelCell *)oneObject;
            }
        }
    }
    cell.selTypeLB.text = [self.dataArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark -
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selRow = indexPath.row;
}
- (IBAction)confirmAction:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{}];
}
@end
