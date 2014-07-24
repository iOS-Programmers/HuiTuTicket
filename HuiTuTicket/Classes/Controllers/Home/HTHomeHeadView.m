//
//  HTHomeHeadView.m
//  HuiTuTicket
//
//  Created by Bird on 14-7-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeHeadView.h"
#import "HTTicketRegisterController.h"
#import "HTCYOrderViewController.h"

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

- (UIViewController *)viewController
{
    for (UIView* next = [self superview]; next; next = next.superview)
    {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

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
            HTTicketRegisterController *vc = [[HTTicketRegisterController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
            break;
        case 103:
        {
            HTCYOrderViewController *vc = [[HTCYOrderViewController alloc] initWithNibName:@"HTCYOrderViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [[self viewController].navigationController pushViewController:vc animated:YES];

        }
            break;
            
        default:
            break;
    }

}
@end
