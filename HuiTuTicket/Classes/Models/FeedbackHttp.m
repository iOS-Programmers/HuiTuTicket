//
//  FeedbackHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "FeedbackHttp.h"

@implementation FeedbackHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[FeedbackPara alloc] init];
        self.resultModel = [[Feedback alloc] init];
        self.apiFuncName = @"common.feedback.post";
        self.api_url = kURL_ScenicTicket_Pre;
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
