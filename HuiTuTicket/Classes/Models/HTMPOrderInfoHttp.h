//
//  HTMPOrderInfoHttp.h
//  HuiTuTicket
//
//  Created by Bird on 14-9-11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "HTMPOrderInfo.h"
#import "HTMPOrderInfoPara.h"

/**
 *  提交订单到服务端
 */
@interface HTMPOrderInfoHttp : LXHttpModel
@property (nonatomic, strong) HTMPOrderInfoPara *parameter;
@property (nonatomic, strong) HTMPOrderInfo *resultModel;

/**
 *  设置是套票或者是门票的接口
 */
@property (nonatomic) BOOL isTaoPiao;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
