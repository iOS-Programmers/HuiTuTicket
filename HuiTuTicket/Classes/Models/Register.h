//
//  Register.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXDataModel.h"

/**
 *  注册接口返回数据对象
 */
@interface Register : LXDataModel


@property (strong, nonatomic) NSString *userid;         //会员ID

@property (strong, nonatomic) NSString *mobile;         //会员注册手机号

@property (strong, nonatomic) NSString *session_key;    //会员登录key

@property (strong, nonatomic) NSString *expires;        //登录有效期 （数字型时间戳，到期时间的毫秒值）

@end
