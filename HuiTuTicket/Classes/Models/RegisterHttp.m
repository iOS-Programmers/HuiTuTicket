//
//  RegisterHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "RegisterHttp.h"

@implementation RegisterHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[RegisterPara alloc] init];
        self.resultModel = [[Register alloc] init];
        self.apiFuncName = @"user.register";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{

    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
