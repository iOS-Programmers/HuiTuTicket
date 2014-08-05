//
//  TicketScenicSpotListHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketScenicSpotListPara.h"
#import "TicketScenicSpotList.h"

/**
 *  联票产品包含景区获取接口
 */
@interface TicketScenicSpotListHttp : LXHttpModel

@property (nonatomic, retain) TicketScenicSpotListPara *parameter;
@property (nonatomic, retain) TicketScenicSpotList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
