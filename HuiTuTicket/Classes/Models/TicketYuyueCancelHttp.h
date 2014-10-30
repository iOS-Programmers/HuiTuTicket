//
//  TicketYuyueCancelHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketYuyueCancel.h"
#import "TicketYuyueCancelPara.h"

/**
 *  联票预约取消接口
 */
@interface TicketYuyueCancelHttp : LXHttpModel

@property (nonatomic, retain) TicketYuyueCancelPara *parameter;
@property (nonatomic, retain) TicketYuyueCancel *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
