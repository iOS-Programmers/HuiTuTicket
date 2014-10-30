//
//  TicketBindHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketBind.h"
#import "TicketBindPara.h"

/**
 *  联票绑定接口
 */
@interface TicketBindHttp : LXHttpModel

@property (nonatomic, retain) TicketBindPara *parameter;
@property (nonatomic, retain) TicketBind *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
