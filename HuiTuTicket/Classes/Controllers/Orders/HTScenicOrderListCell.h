//
//  HTScenicOrderListCell.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TicketOrderModel;
@interface HTScenicOrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *scenicName;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *tourTime;
@property (weak, nonatomic) IBOutlet UILabel *orderTime;
@property (weak, nonatomic) IBOutlet UILabel *orderStatus;

- (void)configureWithData:(TicketOrderModel *)info;

@end
