//
//  HTLPTicketListCell.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/9.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLPTicketListCell.h"
#import "LPTicket.h"

@implementation HTLPTicketListCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureWithData:(LPTicket *)ticketInfo
{
    if (ticketInfo) {        
        if (!FBIsEmpty(ticketInfo.picurl)) {
            [self.imgeView setImageWithURL:[NSURL URLWithString:ticketInfo.picurl] placeholderImage:nil];
        }
        self.lpNameLB.text = ticketInfo.lpName;
        self.lpScenicLabel.text = ticketInfo.scenic_num;
        self.lpCompanyLabel.text = ticketInfo.company;
    }
    
}

@end
