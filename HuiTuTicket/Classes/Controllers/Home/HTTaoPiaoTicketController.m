//
//  HTTaoPiaoTicketController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/15.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTTaoPiaoTicketController.h"

#import "HTTaopiaoListCell.h"

#import "HTTaoPiaoDetailController.h"

@interface HTTaoPiaoTicketController ()

@end

@implementation HTTaoPiaoTicketController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"景区套票";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 80;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return [self.dataSource count];
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    HTTaopiaoListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HTTaopiaoListCell" owner:self options:nil] lastObject];
    }
    //    TicketModel *model = [self.dataSource objectAtIndex:indexPath.row];
    //    cell.nameLabel.text = model.ticketName;
    //    cell.priceLabel.text = model.bookprice;
    //    cell.placeLabel.text = model.state;
    //    cell.oriPriceLabel.text = model.price;
    
//    Scenic *scenic = [self.dataSource objectAtIndex:indexPath.row];
//    [cell.sceneIV setImageWithURL:[NSURL URLWithString:scenic.picture]];
//    cell.nameLabel.text = scenic.scenicName;
//    cell.levelLabel.text = scenic.rank;
//    cell.placeLabel.text = scenic.address;
//    cell.priceLabel.text = scenic.minprice;
//    cell.oriPriceLabel.text = scenic.price;
    return cell;
}

#pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    Scenic *scenic = [self.dataSource objectAtIndex:indexPath.row];
    HTTaoPiaoDetailController *app = [[HTTaoPiaoDetailController alloc] init];
    app.hidesBottomBarWhenPushed = YES;
//    app.scenicId = scenic.scenicId;
    [self.navigationController pushViewController:app animated:YES];
}


@end
