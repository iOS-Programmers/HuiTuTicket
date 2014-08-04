//
//  LoginPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface LoginPara : LXParameterModel

/**
 *  会员ID   int型
 */
@property (strong, nonatomic) NSString *username;

/**
 *  会员注册手机号
 */
@property (strong, nonatomic) NSString *password;

/**
 *  会员登录key
 */
@property (strong, nonatomic) NSString *session_key;

/**
 *  APP版本号   非必传
 */
@property (strong, nonatomic) NSString *app_ver;

/**
 *  返回数据的格式  json或xml, get方式传递
 *  非必传
 */
@property (strong, nonatomic) NSString *format;


@end
