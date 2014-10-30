//
//  TicketOrderDetailHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TicketOrderDetail.h"
#import "TicketOrderDetailPara.h"

/**
 *  景区门票订单详情获取接口
 */
@interface TicketOrderDetailHttp : LXHttpModel
@property (nonatomic, strong) TicketOrderDetailPara *parameter;
@property (nonatomic, strong) TicketOrderDetail *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
