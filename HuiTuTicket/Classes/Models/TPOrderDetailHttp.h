//
//  TPOrderDetailHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TPOrderDetail.h"
#import "TPOrderDetailPara.h"

@interface TPOrderDetailHttp : LXHttpModel
@property (nonatomic, retain) TPOrderDetailPara *parameter;
@property (nonatomic, retain) TPOrderDetail *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
