//
//  TicketYuyueSubmitHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/12.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketYuyueSubmit.h"
#import "TicketYuyueSubmitPara.h"

@interface TicketYuyueSubmitHttp : LXHttpModel

@property (nonatomic, retain) TicketYuyueSubmitPara *parameter;
@property (nonatomic, retain) TicketYuyueSubmit *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
