//
//  TicketOrderQueryHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketOrderQueryHttp.h"

@implementation TicketOrderQueryHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketOrderQueryPara alloc] init];
        self.resultModel = [[TicketOrderQuery alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"scenic.ticket.order.list";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
