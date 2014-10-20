//
//  ResetPasswordHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "ResetPasswordHttp.h"

@implementation ResetPasswordHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[ResetPasswordPara alloc] init];
        self.resultModel = [[ResetPassword alloc] init];
        self.apiFuncName = @"user.password.set";
        self.api_url = kURL_Member_Pre;
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
