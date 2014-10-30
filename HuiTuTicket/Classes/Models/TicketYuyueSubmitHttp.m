//
//  TicketYuyueSubmitHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/12.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketYuyueSubmitHttp.h"

@implementation TicketYuyueSubmitHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketYuyueSubmitPara alloc] init];
        self.resultModel = [[TicketYuyueSubmit alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.order.post";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
