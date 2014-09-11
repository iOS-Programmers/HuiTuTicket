//
//  HTCYOrderViewController.h
//  HuiTuTicket
//
//  Created by Bird on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseTableViewController.h"
@class MyTicketDetailInfo;
@interface HTCYOrderViewController : HTBaseTableViewController

/**
 *  上级页面传过来的
 */
@property (strong, nonatomic) MyTicketDetailInfo *ticketdetail;

@end
