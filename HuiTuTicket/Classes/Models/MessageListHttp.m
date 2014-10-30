//
//  MessageListHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "MessageListHttp.h"

@implementation MessageListHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[MessageListPara alloc] init];
        self.resultModel = [[MessageList alloc] init];
        self.api_url = kURL_Message_Pre;
        self.apiFuncName = @"user.message.list";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
