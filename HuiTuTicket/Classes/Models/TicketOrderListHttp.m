//
//  TicketOrderListHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketOrderListHttp.h"

@implementation TicketOrderListHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketOrderListPara alloc] init];
        self.resultModel = [[TicketOrderList alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.order.list";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
