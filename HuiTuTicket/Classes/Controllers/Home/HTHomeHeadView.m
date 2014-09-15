//
//  HTHomeHeadView.m
//  HuiTuTicket
//
//  Created by Bird on 14-7-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTHomeHeadView.h"
#import "HTEntranceTicketController.h"
#import "HTLPTicketListController.h"
#import "HTTicketRegisterController.h"
#import "HTYuYueViewController.h"

#import "HTTaoPiaoTicketController.h"
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
            //景区门票
            HTEntranceTicketController *entranceTicket = [[HTEntranceTicketController alloc] init];
            entranceTicket.hidesBottomBarWhenPushed = YES;
            [[self viewController].navigationController pushViewController:entranceTicket animated:YES];
        }
            break;
        case 101:
        {
            //景区联票
            HTLPTicketListController *lpTicket = [[HTLPTicketListController alloc] init];
            lpTicket.hidesBottomBarWhenPushed =YES;
            [[self viewController].navigationController pushViewController:lpTicket animated:YES];
        }
            break;
        case 102:
        {
            //联票注册
            HTTicketRegisterController *vc = [[HTTicketRegisterController alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [[self viewController].navigationController pushViewController:vc animated:YES];
        }
            break;
        case 103:
        {
            //出游预约
            HTYuYueViewController *vc = [[HTYuYueViewController alloc] initWithNibName:@"HTYuYueViewController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [[self viewController].navigationController pushViewController:vc animated:YES];

        }
            break;
        case 104:
        {
            //景区套票
            HTTaoPiaoTicketController *vc = [[HTTaoPiaoTicketController alloc] initWithNibName:@"HTTaoPiaoTicketController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [[self viewController].navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        default:
            break;
    }

}
@end
