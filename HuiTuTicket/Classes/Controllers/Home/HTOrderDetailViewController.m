//
//  HTOrderDetailViewController.m
//  HuiTuTicket
//
//  Created by Bird on 14-7-25.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTOrderDetailViewController.h"
#import "HTCustomDateCell.h"
#import "HTCustomMapCell.h"



#define HTDATA_ARRAY @[@{@"游览景区":@[@"景区名称",@"景区等级",@"优惠方式",@"游览限时",@"景区地址"]},@{@"游览日期":@[@"选择日期"]},@{@"预约人":@[@"联票号码",@"注册人",@"证件号码"]}]

#define HTFAKE_ARRAY @[@{@"游览景区":@[@"西峡鹳河漂流",@"AAAA",@"免票",@"不限时",@"中国 河南 西峡"]},@{@"游览日期":@[@"2014-06-25  明天"]},@{@"预约人":@[@"123423451234",@"张三",@"4101011985010227564"]}]

@interface HTOrderDetailViewController ()

@end

@implementation HTOrderDetailViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - TableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark - TableView DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [HTDATA_ARRAY count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [[[HTDATA_ARRAY objectAtIndex:section] allValues]objectAtIndex:0];
    return [array  count];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSArray *array = [[HTDATA_ARRAY objectAtIndex:section] allKeys];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 21)];
    headView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(13, 1, 100, 20)];
    label.textColor = [UIColor darkGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    label.text = [array objectAtIndex:0];
    [headView addSubview:label];
    return headView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    if (indexPath.section==1&&indexPath.row==0)
    {
        HTCustomDateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTCustomDateCell" owner:self options:nil];
            for (id oneObject in cellNib)
            {
                if ([oneObject isKindOfClass:[HTCustomDateCell class]])
                {
                    cell = (HTCustomDateCell *)oneObject;
                }
            }
        }
        NSArray *array = [[[HTDATA_ARRAY objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
        cell.leftLB.text = [array objectAtIndex:indexPath.row];
        NSArray *dataArray = [[[HTFAKE_ARRAY objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
        [cell.dateSelBtn setTitle:[dataArray objectAtIndex:indexPath.row] forState:UIControlStateNormal];
        return cell;
    }
    else
    {
        HTCustomMapCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil)
        {
            NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTCustomMapCell" owner:self options:nil];
            for (id oneObject in cellNib)
            {
                if ([oneObject isKindOfClass:[HTCustomMapCell class]])
                {
                    cell = (HTCustomMapCell *)oneObject;
                }
            }
        }
        if (indexPath.section==0&&indexPath.row==4)
        {
            cell.mapBtn.hidden = NO;
        }
        NSArray *array = [[[HTDATA_ARRAY objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
        NSArray *dataArray = [[[HTFAKE_ARRAY objectAtIndex:indexPath.section] allValues]objectAtIndex:0];
        cell.leftLabel.text = [array objectAtIndex:indexPath.row];
        cell.rightLabel.text = [dataArray objectAtIndex:indexPath.row];
        return cell;
    }
}




@end
