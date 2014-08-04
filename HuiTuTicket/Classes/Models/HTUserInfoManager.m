//
//  HTUserInfoManager.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTUserInfoManager.h"

@implementation HTUserInfoManager


+ (instancetype)shareInfoManager
{
    static dispatch_once_t onceToken;
    
    static HTUserInfoManager *sharedInfo = nil;
    dispatch_once(&onceToken, ^{
        sharedInfo = [[HTUserInfoManager alloc] init];
    });
    
    return sharedInfo;
}
@end
