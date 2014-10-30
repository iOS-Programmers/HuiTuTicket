//
//  GetUserInfoHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "GetUserInfoHttp.h"

@implementation GetUserInfoHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[GetUserInfoPara alloc] init];
        self.resultModel = [[GetUserInfo alloc] init];
        self.apiFuncName = @"user.info";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
