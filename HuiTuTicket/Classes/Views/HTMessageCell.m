//
//  HTMessageCell.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMessageCell.h"

@implementation HTMessageCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureUIWithData:(MessageDetail *)detail
{
    if (detail) {
        self.titleLabel.text = detail.title;
        self.detailTextLabel.text = detail.content;
        self.timeLabel.text = detail.addtime;
    }
}

@end
