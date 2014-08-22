//
//  HomeBannerHttp.m
//  HuiTuTicket
//
//  Created by Bird on 14-8-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HomeBannerHttp.h"

@implementation HomeBannerHttp

- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[HomeBannerPara alloc] init];
        self.resultModel = [[HomeBanner alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_COMMON_Pre;
        self.apiFuncName = @"common.ad.info";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
