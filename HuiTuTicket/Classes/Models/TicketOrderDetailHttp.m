//
//  TicketOrderDetailHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketOrderDetailHttp.h"

@implementation TicketOrderDetailHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketOrderDetailPara alloc] init];
        self.resultModel = [[TicketOrderDetail alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"scenic.ticket.order.info";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
