//
//  LogoutPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

/**
 *  退出登录接口入参对象
 */
@interface LogoutPara : LXParameterModel

/**
 *  会员ID 注册手机号或邮箱
 */
@property (strong, nonatomic) NSString *uid;

/**
 *  登录key
 */
@property (strong, nonatomic) NSString *session_key;

@end
