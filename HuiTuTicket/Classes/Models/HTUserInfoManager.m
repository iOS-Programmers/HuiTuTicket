//
//  HTUserInfoManager.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTUserInfoManager.h"
#import "GetUserInfo.h"

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

/**
 *  获取会员信息的对象
 *
 *  @return 会员信息
 */
- (GetUserInfo *)userInfo
{
    GetUserInfo *info;

    info = (GetUserInfo *)[[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO];
    
    return info;
}
@end
