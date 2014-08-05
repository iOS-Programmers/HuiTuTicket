//
//  TicketRegisterPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketRegisterPara : LXParameterModel


/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codenumber;

/**
 *  注册人姓名
 */
@property (strong, nonatomic) NSString *username;

/**
 *  性别 0-男 1-女
 */
@property (strong, nonatomic) NSString *sex;

/**
 *  注册人手机号
 */
@property (strong, nonatomic) NSString *mobile;

/**
 *  证件类型  0-身份证 1-军官证
 */
@property (strong, nonatomic) NSString *idtype;

/**
 *  证件号码
 */
@property (strong, nonatomic) NSString *idcard;

/**
 *  城市行政区划  6位城市行政区划代码
 */
@property (strong, nonatomic) NSString *citycode;


@end
