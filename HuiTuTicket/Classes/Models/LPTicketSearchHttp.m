//
//  LPTicketSearchHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LPTicketSearchHttp.h"

@implementation LPTicketSearchHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[LPTicketSearchPara alloc] init];
        self.resultModel = [[LPTicketSearch alloc] init];
        self.apiFuncName = @"lp.code.info";
        self.api_url = kURL_Ticket_Pre;
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
