//
//  HTAppointmentCell.m
//  HuiTuTicket
//
//  Created by viewalloc on 14-8-3.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTAppointmentCell.h"

@implementation HTAppointmentCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configueUIWithData:(LPTicketOrderDetail *)info
{
    if (info) {
        self.orderNameLabel.text = info.scenicName;
        self.orderNumLabel.text = [NSString stringWithFormat:@"票号：%@",info.codeNumber];
        self.orderDateLabel.text = [NSString stringWithFormat:@"日期：%@",info.traveltime];
        self.biaojiLabel.text = [info.state isEqualToString:@"0"] ? @"未出游" : @"已出游";
    }
}

@end
