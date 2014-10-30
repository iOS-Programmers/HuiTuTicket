//
//  TicketDetailHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketDetail.h"
#import "TicketDetailPara.h"

/**
 *  联票产品详情获取接口
 */
@interface TicketDetailHttp : LXHttpModel

@property (nonatomic, retain) TicketDetailPara *parameter;
@property (nonatomic, retain) TicketDetail *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
