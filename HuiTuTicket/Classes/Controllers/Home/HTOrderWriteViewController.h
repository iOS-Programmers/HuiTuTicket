//
//  HTOrderWriteViewController.h
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseTableViewController.h"
#import "TicketModel.h"

@interface HTOrderWriteViewController : HTBaseTableViewController
@property (nonatomic, copy) NSString *scenicId;
@property (nonatomic, strong) TicketModel *dataModel;

@end
