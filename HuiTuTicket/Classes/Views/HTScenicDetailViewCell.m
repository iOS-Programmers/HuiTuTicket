//
//  HTScenicDetailViewCell.m
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTScenicDetailViewCell.h"

@implementation HTScenicDetailViewCell

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)buyAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:BUY_MP_NOTIFICATON object:self.model];
}
@end
