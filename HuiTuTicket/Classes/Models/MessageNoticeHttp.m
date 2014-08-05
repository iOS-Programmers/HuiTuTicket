//
//  MessageNoticeHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "MessageNoticeHttp.h"

@implementation MessageNoticeHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[MessageNoticePara alloc] init];
        self.resultModel = [[MessageNotice alloc] init];
        self.api_url = kURL_Message_Pre;
        self.apiFuncName = @"user.message.newcount";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
