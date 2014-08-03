//
//  HTAppointmentViewController.m
//  HuiTuTicket
//
//  Created by viewalloc on 14-8-3.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTAppointmentViewController.h"
#import "HTAppointmentCell.h"
@interface HTAppointmentViewController ()

@end

@implementation HTAppointmentViewController

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
    // Do any additional setup after loading the view.
    self.title = @"预约记录";
    self.dataSource = [[NSMutableArray alloc] initWithArray:@[@"1",@"2"]];
    self.tableView.rowHeight = 80;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // in subClass
    static NSString *CellIdentifier = @"Cell";
    HTAppointmentCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        NSArray *cellNib = [[NSBundle mainBundle] loadNibNamed:@"HTAppointmentCell" owner:self options:nil];
        for (id oneObject in cellNib)
        {
            if ([oneObject isKindOfClass:[HTAppointmentCell class]])
            {
                cell = (HTAppointmentCell *)oneObject;
            }
        }
    }
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
