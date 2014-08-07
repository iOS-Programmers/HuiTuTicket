//
//  LPTicketListHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LPTicketListHttp.h"

@implementation LPTicketListHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[LPTicketListPara alloc] init];
        self.resultModel = [[LPTicketList alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.type.list";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
