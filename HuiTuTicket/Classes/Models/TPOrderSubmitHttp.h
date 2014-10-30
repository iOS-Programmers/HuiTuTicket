//
//  TPOrderSubmitHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TPOrderSubmit.h"
#import "TPOrderSubmitPara.h"

@interface TPOrderSubmitHttp : LXHttpModel
@property (nonatomic, retain) TPOrderSubmitPara *parameter;
@property (nonatomic, retain) TPOrderSubmit *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
