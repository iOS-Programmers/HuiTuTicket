//
//  TicketYuYueDetailHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketYuYueDetail.h"
#import "TicketYuYueDetailPara.h"

/**
 *  联票预约详情获取
 */
@interface TicketYuYueDetailHttp : LXHttpModel

@property (nonatomic, retain) TicketYuYueDetailPara *parameter;
@property (nonatomic, retain) TicketYuYueDetail *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
