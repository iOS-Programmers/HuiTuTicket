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

    NSData *myEncodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:USER_INFO];
    info = (GetUserInfo *)[NSKeyedUnarchiver unarchiveObjectWithData: myEncodedObject];
    
    return info;
}

/**
 *  保存个人信息
 *
 *  @param info 个人信息对象
 */
- (void)saveUserInfo:(GetUserInfo *)info
{
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:info];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:myEncodedObject forKey:USER_INFO];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
