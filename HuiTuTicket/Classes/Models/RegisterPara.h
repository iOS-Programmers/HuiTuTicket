//
//  RegisterPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface RegisterPara : LXParameterModel


/**
 *  用户手机号   11位有效手机号码
 */
@property (strong, nonatomic) NSString *mobile;

/**
 *  登录密码
 *  不能包含中文
 */
@property (strong, nonatomic) NSString *password;

/**
 *  参数MD5校验串
 */
@property (strong, nonatomic) NSString *sig;

/**
 *  APP版本号   非必传
 */
@property (strong, nonatomic) NSString *app_ver;

/**
 *  返回数据的格式  json或xml, get方式传递
 *  非必传
 */
@property (strong, nonatomic) NSString *format;  

/*
 参数校验串生成方法：将请求参数中的mobile、password、key三个参数的value值拼成一个无间隔的字符串(顺序不要改变)，其中 key是参数签名密钥。
 MD5字符串示例：
 13800138000123456key
 用32位MD5函数加密该字符串所得值即为我们所需的校验串。
 注意：得出的32位MD5值需转化为小写。
 
 */

@end
