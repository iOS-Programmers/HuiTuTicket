//
//  HTMyTicketCell.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTicket;

@interface HTMyTicketCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lpCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *lpTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lpNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lpUserLabel;

@property (weak, nonatomic) IBOutlet UILabel *lpEndtimeLabel;


- (void)configureWithData:(MyTicket *)info;

@end
