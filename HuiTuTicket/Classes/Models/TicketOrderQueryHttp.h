//
//  TicketOrderQueryHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketOrderQuery.h"
#import "TicketOrderQueryPara.h"

@interface TicketOrderQueryHttp : LXHttpModel
@property (nonatomic, strong) TicketOrderQueryPara *parameter;
@property (nonatomic, strong) TicketOrderQuery *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
