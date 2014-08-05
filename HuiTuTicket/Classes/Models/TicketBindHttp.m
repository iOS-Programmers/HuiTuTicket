//
//  TicketBindHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketBindHttp.h"

@implementation TicketBindHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketBindPara alloc] init];
        self.resultModel = [[TicketBind alloc] init];
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"user.lp.bind";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
