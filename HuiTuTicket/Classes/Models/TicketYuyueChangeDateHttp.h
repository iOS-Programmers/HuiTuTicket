//
//  TicketYuyueChangeDateHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketYuyueChangeDate.h"
#import "TicketYuyueChangeDatePara.h"

/**
 *  联票预约改期提交接口
 */
@interface TicketYuyueChangeDateHttp : LXHttpModel

@property (nonatomic, retain) TicketYuyueChangeDatePara *parameter;
@property (nonatomic, retain) TicketYuyueChangeDate *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
