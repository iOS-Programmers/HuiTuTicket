//
//  TouchTableView.m
//  HuiTuTicket
//
//  Created by LiTong on 14/10/29.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TouchTableView.h"

@implementation TouchTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
#pragma mark - Touch UITableView DataSource
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)])
    {
        [_touchDelegate tableView:(id)self touchesBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesCancelled:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesCancelled:withEvent:)])
    {
        [_touchDelegate tableView:(id)self touchesCancelled:touches withEvent:event];
    }
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesEnded:withEvent:)])
    {
        [_touchDelegate tableView:(id)self touchesEnded:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    
    if ([_touchDelegate conformsToProtocol:@protocol(TouchTableViewDelegate)] &&
        [_touchDelegate respondsToSelector:@selector(tableView:touchesMoved:withEvent:)])
    {
        [_touchDelegate tableView:(id)self touchesMoved:touches withEvent:event];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
