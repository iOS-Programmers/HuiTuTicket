//
//  TicketOrderCancelHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketOrderCancel.h"
#import "TicketOrderCancelPara.h"

@interface TicketOrderCancelHttp : LXHttpModel
@property (nonatomic, strong) TicketOrderCancelPara *parameter;
@property (nonatomic, strong) TicketOrderCancel *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
