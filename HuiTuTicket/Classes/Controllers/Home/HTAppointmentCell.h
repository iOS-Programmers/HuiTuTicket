//
//  HTAppointmentCell.h
//  HuiTuTicket
//
//  Created by viewalloc on 14-8-3.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HTAppointmentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *biaojiLabel;

@end
