//
//  HTOrderDetailViewController.h
//  HuiTuTicket
//
//  Created by Bird on 14-7-25.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseTableViewController.h"
@class MyTicketDetailInfo;
@class TicketScenicSpot;

@interface HTOrderDetailViewController : HTBaseTableViewController

/**
 *  上级页面传过来的 联票数据
 */
@property (strong, nonatomic) MyTicketDetailInfo *ticketdetail;

/**
 *  上级页面传过来的 联票景区详情数据
 */
@property (strong, nonatomic) TicketScenicSpot *scenicDetail;

@end
