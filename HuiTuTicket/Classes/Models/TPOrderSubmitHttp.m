//
//  TPOrderSubmitHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TPOrderSubmitHttp.h"

@implementation TPOrderSubmitHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TPOrderSubmitPara alloc] init];
        self.resultModel = [[TPOrderSubmit alloc] init];
        self.api_url = kURL_TaoPiao_Pre;
        self.apiFuncName = @"tp.order.post";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}
@end
