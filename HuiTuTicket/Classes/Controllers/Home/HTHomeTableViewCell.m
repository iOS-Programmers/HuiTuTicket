//
//  HTHomeTableViewCell.m
//  HuiTuTicket
//
//  Created by Bird on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeTableViewCell.h"

@implementation HTHomeTableViewCell

- (void)awakeFromNib
{
    PriceLable *lab = [[PriceLable alloc] initWithFrame:(CGRect){{262,44},{49,16}}];
    lab.textAlignment = NSTextAlignmentRight;
    lab.font = [UIFont fontWithName:@"Arial"size:13];
    lab.textColor = [UIColor blackColor];
    [self addSubview:lab];
    self.oldPriceLab = lab;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
