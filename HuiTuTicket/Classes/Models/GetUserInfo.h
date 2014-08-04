//
//  GetUserInfo.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

/**
 *  获取会员信息接口的对象
 */
@interface GetUserInfo : LXResultModel

/**
 *  会员ID   int型
 */
@property (strong, nonatomic) NSString *userid;

/**
 *  会员注册手机号
 */
@property (strong, nonatomic) NSString *mobile;

/**
 *  会员头像地址
 */
@property (strong, nonatomic) NSString *headpic;

/**
 *  会员昵称
 */
@property (strong, nonatomic) NSString *nickname;

/**
 *  性别  0-男 1-女
 */
@property (strong, nonatomic) NSString *sex;

/**
 *  真实姓名
 */
@property (strong, nonatomic) NSString *realname;

/**
 *  电子邮箱
 */
@property (strong, nonatomic) NSString *email;

/**
 *  所在地
 */
@property (strong, nonatomic) NSString *city;

/**
 *  注册时间
 */
@property (strong, nonatomic) NSString *regtime;

@end
