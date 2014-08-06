//
//  TicketOrderSubmitHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketOrderSubmitHttp.h"

@implementation TicketOrderSubmitHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketOrderSubmitPara alloc] init];
        self.resultModel = [[TicketOrderSubmit alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"scenic.ticket.order.post";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
