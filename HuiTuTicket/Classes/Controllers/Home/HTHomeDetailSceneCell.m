//
//  HTHomeDetailSceneCell.m
//  HuiTuTicket
//
//  Created by Bird on 14/10/21.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeDetailSceneCell.h"

@implementation HTHomeDetailSceneCell

- (void)awakeFromNib {
    
    self.downLabel.lineBreakMode=NSLineBreakByCharWrapping;
    self.downLabel.numberOfLines = 0;
    self.downLabel.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
    self.downLabel.backgroundColor = [UIColor clearColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
