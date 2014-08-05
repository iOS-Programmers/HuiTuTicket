//
//  TicketUnbindHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketUnbindHttp.h"

@implementation TicketUnbindHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketUnbindPara alloc] init];
        self.resultModel = [[TicketUnbind alloc] init];
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"user.lp.unbind";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}
@end
