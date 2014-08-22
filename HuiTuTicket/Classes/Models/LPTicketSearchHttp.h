//
//  LPTicketSearchHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "LPTicketSearch.h"
#import "LPTicketSearchPara.h"

@interface LPTicketSearchHttp : LXHttpModel

@property (nonatomic, retain) LPTicketSearchPara *parameter;
@property (nonatomic, retain) LPTicketSearch *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
