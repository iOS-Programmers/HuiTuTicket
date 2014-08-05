//
//  TicketDetailHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketDetailHttp.h"

@implementation TicketDetailHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketDetailPara alloc] init];
        self.resultModel = [[TicketDetail alloc] init];
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"lp.type.info";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}



@end
