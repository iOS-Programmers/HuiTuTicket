//
//  TPOrderListHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TPOrderListHttp.h"

@implementation TPOrderListHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TPOrderListPara alloc] init];
        self.resultModel = [[TPOrderList alloc] init];
        self.api_url = kURL_TaoPiao_Pre;
        self.apiFuncName = @"tp.order.list";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}
@end
