//
//  TaoPiaoProductListHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TaoPiaoProductListHttp.h"

@implementation TaoPiaoProductListHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TaoPiaoProductListPara alloc] init];
        self.resultModel = [[TaoPiaoProductList alloc] init];
        self.api_url = kURL_TaoPiao_Pre;
        self.apiFuncName = @"tp.list";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
