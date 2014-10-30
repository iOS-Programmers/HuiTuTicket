//
//  TicketPriceCalendarHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketPriceCalendar.h"
#import "TicketPriceCalendarPara.h"

/**
 *  景区门票价格日历接口
 */
@interface TicketPriceCalendarHttp : LXHttpModel
@property (nonatomic, strong) TicketPriceCalendarPara *parameter;
@property (nonatomic, strong) TicketPriceCalendar *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
