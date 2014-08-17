//
//  TicketOrderListHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketOrderList.h"
#import "TicketOrderListPara.h"

/**
 *  联票预约记录
 */
@interface TicketOrderListHttp : LXHttpModel

@property (nonatomic, retain) TicketOrderListPara *parameter;
@property (nonatomic, retain) TicketOrderList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
