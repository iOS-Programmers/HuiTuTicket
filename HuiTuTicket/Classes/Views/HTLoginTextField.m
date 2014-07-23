//
//  HTLoginTextField.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-23.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTLoginTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation HTLoginTextField

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
    self.layer.borderColor = [UIColorRGB(235, 235, 235) CGColor];
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    [super drawPlaceholderInRect:rect];
    if (_placeholderColor) {
        [[self placeholder] drawInRect:rect withAttributes:@{NSForegroundColorAttributeName:_placeholderColor}];
    }
}

//控制placeHolder的位置，左右缩20
//-(CGRect)placeholderRectForBounds:(CGRect)bounds
//{
////    return CGRectInset(bounds, 10, 4);

//}

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    return CGRectInset(bounds, 10, 0);
}


@end
