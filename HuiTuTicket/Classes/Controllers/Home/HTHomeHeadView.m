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
#import "HTLPHomeController.h"
#import "HTTaoPiaoTicketController.h"

#import "HTMyTicketController.h"
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
            //景区联票
            HTLPHomeController *lpTicket = [[HTLPHomeController alloc] init];
            lpTicket.hidesBottomBarWhenPushed =YES;
            [[self viewController].navigationController pushViewController:lpTicket animated:YES];
        }
            break;
        case 101:
        {
                //景区套票
            HTTaoPiaoTicketController *vc = [[HTTaoPiaoTicketController alloc] initWithNibName:@"HTTaoPiaoTicketController" bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [[self viewController].navigationController pushViewController:vc animated:YES];
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
            //用户未登录 进入出游预约界面
            if ([[[HTUserInfoManager shareInfoManager] sessionKey] length] < 1) {
                HTYuYueViewController *vc = [[HTYuYueViewController alloc] initWithNibName:@"HTYuYueViewController" bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [[self viewController].navigationController pushViewController:vc animated:YES];
            }
            else {
                //用户登陆后进入我的联票界面
                HTMyTicketController *myTicket = [[HTMyTicketController alloc] init];
                myTicket.hidesBottomBarWhenPushed = YES;
                [[self viewController].navigationController pushViewController:myTicket animated:YES];
            }
            
            
            

        }
            break;

        default:
            break;
    }

}
@end
