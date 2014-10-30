//
//  HTBorderButton.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/10.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBorderButton.h"

@implementation HTBorderButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [kBorderColor CGColor];
}


@end
