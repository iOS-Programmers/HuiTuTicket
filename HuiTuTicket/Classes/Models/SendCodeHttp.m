//
//  SendCodeHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "SendCodeHttp.h"

@implementation SendCodeHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[SendCodePara alloc] init];
        self.resultModel = [[SendCode alloc] init];
        self.apiFuncName = @"user.validcode.send";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
