//
//  HTScenicDetailViewCell.h
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TicketModel.h"
@interface HTScenicDetailViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *ticketNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *oriPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnMoneyLabel;

@property (strong, nonatomic) TicketModel *model;

- (IBAction)buyAction:(id)sender;

@end
