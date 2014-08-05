//
//  TicketRegisterHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketRegister.h"
#import "TicketRegisterPara.h"

/**
 *  联票注册接口
 */
@interface TicketRegisterHttp : LXHttpModel

@property (nonatomic, retain) TicketRegisterPara *parameter;
@property (nonatomic, retain) TicketRegister *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
