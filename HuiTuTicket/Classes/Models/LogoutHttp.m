//
//  LogoutHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LogoutHttp.h"

@implementation LogoutHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[LogoutPara alloc] init];
        self.resultModel = [[Logout alloc] init];
        self.apiFuncName = @"user.logout";
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
