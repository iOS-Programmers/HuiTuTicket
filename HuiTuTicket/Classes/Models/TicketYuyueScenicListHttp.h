//
//  TicketYuyueScenicListHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketYuyueScenicList.h"
#import "TicketYuyueScenicListPara.h"
/**
 *  联票可预约景区获取接口
 */
@interface TicketYuyueScenicListHttp : LXHttpModel

@property (nonatomic, retain) TicketYuyueScenicListPara *parameter;
@property (nonatomic, retain) TicketYuyueScenicList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
