//
//  TicketOrderSubmitHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketOrderSubmit.h"
#import "TicketOrderSubmitPara.h"

@interface TicketOrderSubmitHttp : LXHttpModel
@property (nonatomic, strong) TicketOrderSubmitPara *parameter;
@property (nonatomic, strong) TicketOrderSubmit *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
