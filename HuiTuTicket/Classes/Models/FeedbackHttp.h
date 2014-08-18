//
//  FeedbackHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "Feedback.h"
#import "FeedbackPara.h"

@interface FeedbackHttp : LXHttpModel


@property (nonatomic, retain) FeedbackPara *parameter;
@property (nonatomic, retain) Feedback *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
