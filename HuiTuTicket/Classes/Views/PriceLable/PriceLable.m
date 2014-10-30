//
//  PriceLable.m
//  LabText
//
//  Created by LiTong on 14-10-22.
//  Copyright (c) 2014年 LiTong. All rights reserved.
//

#import "PriceLable.h"

@implementation PriceLable

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
    [super drawRect:rect];
    CGFloat weight = [NSString contentCellWidhtWithText:self.text fontSize:13 heigth:20];
    UIView *view = [[UIView alloc] initWithFrame:(CGRect){{rect.size.width - weight,rect.size.height/2},{weight,1}}];
    view.backgroundColor = [UIColor redColor];
    [self addSubview:view];
}
@end
