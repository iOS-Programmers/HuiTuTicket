//
//  HTHomeHeadView.m
//  HuiTuTicket
//
//  Created by Bird on 14-7-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeHeadView.h"

@implementation HTHomeHeadView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
# pragma mark -
# pragma mark - Action
- (IBAction)headBtnsClicked:(UIButton *)sender
{
    switch (sender.tag)
    {
        case 100:
        {
            
        }
            break;
        case 101:
        {
            
        }
            break;
        case 102:
        {
            
        }
            break;
        case 103:
        {
            
        }
            break;
            
        default:
            break;
    }

}
@end
