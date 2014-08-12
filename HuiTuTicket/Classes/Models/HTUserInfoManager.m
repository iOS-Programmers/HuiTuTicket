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

/**
 *  设置session_key以及获取session_key的方法
 *
 *  @param sessionKey 会员登录key
 */
- (void)setSessionKey:(NSString *)sessionKey
{
    //每次重新登录后更新下session_key
    [[NSUserDefaults standardUserDefaults] setObject:sessionKey forKey:SESSION_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
- (NSString *)sessionKey
{
    NSString *key;
    if ([[NSUserDefaults standardUserDefaults] objectForKey:SESSION_KEY]) {
        key = (NSString *)[[NSUserDefaults standardUserDefaults] objectForKey:SESSION_KEY];
    }
    
    return key;
}
@end
