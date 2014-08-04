//
//  Login.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXDataModel.h"

/**
 *  登录接口返回数据对象
 */
@interface Login : LXDataModel

/**
 *  会员ID   int型
 */
@property (strong, nonatomic) NSString *userid;

/**
 *  会员注册手机号
 */
@property (strong, nonatomic) NSString *mobile;

/**
 *  会员登录key
 */
@property (strong, nonatomic) NSString *session_key;



/**
 *  {
 'state':'0',
 'data':{
 'userid':'1087',
 'mobile':'13800138000',
 'session_key':'123456',
 'expires': '1405240556'
 },
 'errcode':'0',
 'msg':'ok'
 }
 */
@end
