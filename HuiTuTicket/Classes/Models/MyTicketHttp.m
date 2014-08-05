//
//  MyTicketHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "MyTicketHttp.h"

@implementation MyTicketHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[MyTicketPara alloc] init];
        self.resultModel = [[MyTicket alloc] init];
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"user.lp.list";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
