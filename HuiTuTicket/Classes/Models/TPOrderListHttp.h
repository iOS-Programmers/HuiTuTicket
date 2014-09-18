//
//  TPOrderListHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TPOrderList.h"
#import "TPOrderListPara.h"

@interface TPOrderListHttp : LXHttpModel
@property (nonatomic, retain) TPOrderListPara *parameter;
@property (nonatomic, retain) TPOrderList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
