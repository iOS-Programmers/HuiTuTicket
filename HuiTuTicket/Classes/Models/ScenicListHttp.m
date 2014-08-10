//
//  ScenicListHttp.m
//  HuiTuTicket
//
//  Created by Bird on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "ScenicListHttp.h"

@implementation ScenicListHttp


- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[ScenicListPara alloc] init];
        self.resultModel = [[ScenicList alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_Ticket_Pre;
        self.apiFuncName = @"scenic.list";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
