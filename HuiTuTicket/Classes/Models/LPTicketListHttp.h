//
//  LPTicketListHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "LPTicketList.h"
#import "LPTicketListPara.h"

/**
 *  联票产品列表获取接口
 */
@interface LPTicketListHttp : LXHttpModel

@property (nonatomic, strong) LPTicketListPara *parameter;
@property (nonatomic, strong) LPTicketList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
