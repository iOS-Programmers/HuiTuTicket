//
//  HTYuYueDetailViewController.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseTableViewController.h"
@class LPTicketOrderDetail;

@interface HTYuYueDetailViewController : HTBaseTableViewController

/**
 *  上级页面传过来的
 */
@property (strong, nonatomic) LPTicketOrderDetail *yuyueinfo;

@end
