//
//  TicketYuYueDetailHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketYuYueDetailHttp.h"

@implementation TicketYuYueDetailHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketYuYueDetailPara alloc] init];
        self.resultModel = [[TicketYuYueDetail alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.order.info";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
