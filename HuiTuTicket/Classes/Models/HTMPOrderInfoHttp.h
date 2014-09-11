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

@interface HTMPOrderInfoHttp : LXHttpModel
@property (nonatomic, strong) HTMPOrderInfoPara *parameter;
@property (nonatomic, strong) HTMPOrderInfo *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
