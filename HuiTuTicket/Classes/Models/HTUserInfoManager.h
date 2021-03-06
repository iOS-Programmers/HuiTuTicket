//
//  HTUserInfoManager.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GetUserInfo.h"
/**
 *  储存项目中用户相关信息的类 （调用的时候用单例模式调用）
 */
@interface HTUserInfoManager : NSObject

+ (instancetype)shareInfoManager;

/**
 *  获取会员信息的对象
 *
 *  @return 会员信息
 */
- (GetUserInfo *)userInfo;

/**
 *  保存会员信息
 *
 *  @param info 会员信息对象
 */
- (void)saveUserInfo:(GetUserInfo *)info;

/**
 *  设置session_key以及获取session_key的方法
 *
 *  @param sessionKey 会员登录key
 */
- (void)setSessionKey:(NSString *)sessionKey;
- (NSString *)sessionKey;

/**
 *  设置session_key以及获取session_key的方法
 *
 *  @param sessionKey 会员登录key
 */
- (void)setuserId:(NSString *)userid;
- (NSString *)userId;

@end
