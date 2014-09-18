//
//  HTModelSelCell.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTModelSelCell.h"

@implementation HTModelSelCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    if (selected)
    {
        self.selFlagIV.image = [UIImage imageNamed:@"pub_success_img.png"];
    }
    else
    {
        self.selFlagIV.image = [UIImage imageNamed:@"s_n_detail_pulldown_icon.png"];
    }
}

@end
