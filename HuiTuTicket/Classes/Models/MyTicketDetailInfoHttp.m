//
//  MyTicketDetailInfoHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "MyTicketDetailInfoHttp.h"

@implementation MyTicketDetailInfoHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[MyTicketDetailInfoPara alloc] init];
        self.resultModel = [[MyTicketDetailInfo alloc] init];
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"lp.user.info";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
