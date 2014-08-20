//
//  HTLPTicketDetailCell.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLPTicketDetailCell.h"

@implementation HTLPTicketDetailCell

- (void)awakeFromNib
{
    self.arrowIV.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
