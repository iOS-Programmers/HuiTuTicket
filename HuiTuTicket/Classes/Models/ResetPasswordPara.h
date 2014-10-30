//
//  ResetPasswordPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface ResetPasswordPara : LXParameterModel

/**
 *  会员注册手机号
 */
@property (strong, nonatomic) NSString *mobile;

/**
 *  密码
 */
@property (strong, nonatomic) NSString *password;

/**
 *  验证码
 */
@property (strong, nonatomic) NSString *validcode;
@end
