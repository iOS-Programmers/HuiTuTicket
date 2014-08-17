//
//  ScenicTicketHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "ScenicTicketHttp.h"

@implementation ScenicTicketHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[ScenicTicketPara alloc] init];
        self.resultModel = [[ScenicTicket alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_ScenicTicket_Pre;
        self.apiFuncName = @"scenic.ticket";
        self.method = @"GET";

    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
