//
//  TicketRegisterHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketRegisterHttp.h"

@implementation TicketRegisterHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketRegisterPara alloc] init];
        self.resultModel = [[TicketRegister alloc] init];
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"lp.code.register";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
