//
//  TicketYuyueScenicListHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketYuyueScenicListHttp.h"

@implementation TicketYuyueScenicListHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketYuyueScenicListPara alloc] init];
        self.resultModel = [[TicketYuyueScenicList alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.scenic.sel";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
