//
//  LoginHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LoginHttp.h"

@implementation LoginHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[LoginPara alloc] init];
        self.resultModel = [[Login alloc] init];
        self.apiFuncName = @"user.login";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
