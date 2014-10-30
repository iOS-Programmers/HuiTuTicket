//
//  TaoPiaoProductDetailHttp.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TaoPiaoProductDetailHttp.h"

@implementation TaoPiaoProductDetailHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TaoPiaoProductDetailPara alloc] init];
        self.resultModel = [[TaoPiaoProductDetail alloc] init];
        self.api_url = kURL_TaoPiao_Pre;
        self.apiFuncName = @"tp.info";
    }
    return self;
}


- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
