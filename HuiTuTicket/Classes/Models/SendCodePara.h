//
//  SendCodePara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface SendCodePara : LXParameterModel

/**
 *  会员注册手机号
 */
@property (strong, nonatomic) NSString *mobile;

/**
 *  返回数据的格式  json或xml, get方式传递
 *  非必传
 */
@property (strong, nonatomic) NSString *format;

@end
