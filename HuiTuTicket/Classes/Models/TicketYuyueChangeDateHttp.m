//
//  TicketYuyueChangeDateHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketYuyueChangeDateHttp.h"

@implementation TicketYuyueChangeDateHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketYuyueChangeDatePara alloc] init];
        self.resultModel = [[TicketYuyueChangeDate alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.order.modify";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
