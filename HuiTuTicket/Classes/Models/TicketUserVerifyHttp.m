//
//  TicketUserVerifyHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketUserVerifyHttp.h"

@implementation TicketUserVerifyHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketUserVerifyPara alloc] init];
        self.resultModel = [[TicketUserVerify alloc] init];
        self.apiFuncName = @"lp.code.userverify";
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
