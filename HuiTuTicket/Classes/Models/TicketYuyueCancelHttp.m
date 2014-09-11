//
//  TicketYuyueCancelHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketYuyueCancelHttp.h"

@implementation TicketYuyueCancelHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketYuyueCancelPara alloc] init];
        self.resultModel = [[TicketYuyueCancel alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.order.close";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
