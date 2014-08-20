//
//  TicketScenicSpotListHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketScenicSpotListHttp.h"

@implementation TicketScenicSpotListHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketScenicSpotListPara alloc] init];
        self.resultModel = [[TicketScenicSpotList alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.scenic.list";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
