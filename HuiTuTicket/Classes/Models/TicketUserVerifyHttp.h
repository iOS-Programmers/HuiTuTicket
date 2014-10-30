//
//  TicketUserVerifyHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketUserVerify.h"
#import "TicketUserVerifyPara.h"

@interface TicketUserVerifyHttp : LXHttpModel

@property (nonatomic, retain) TicketUserVerifyPara *parameter;
@property (nonatomic, retain) TicketUserVerify *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
