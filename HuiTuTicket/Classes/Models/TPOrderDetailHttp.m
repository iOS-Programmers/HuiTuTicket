//
//  TPOrderDetailHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TPOrderDetailHttp.h"

@implementation TPOrderDetailHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TPOrderDetailPara alloc] init];
        self.resultModel = [[TPOrderDetail alloc] init];
        self.api_url = kURL_TaoPiao_Pre;
        self.apiFuncName = @"tp.order.info";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}
@end
