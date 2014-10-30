//
//  TPOrderCancelHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TPOrderCancel.h"
#import "TPOrderCancelPara.h"

@interface TPOrderCancelHttp : LXHttpModel
@property (nonatomic, retain) TPOrderCancelPara *parameter;
@property (nonatomic, retain) TPOrderCancel *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
