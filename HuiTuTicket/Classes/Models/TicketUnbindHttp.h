//
//  TicketUnbindHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketUnbind.h"
#import "TicketUnbindPara.h"

/**
 *  联票取消绑定接口
 */
@interface TicketUnbindHttp : LXHttpModel

@property (nonatomic, retain) TicketUnbindPara *parameter;
@property (nonatomic, retain) TicketUnbind *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
