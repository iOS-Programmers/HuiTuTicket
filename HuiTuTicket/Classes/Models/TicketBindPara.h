//
//  TicketBindPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketBindPara : LXParameterModel

/**
 *  会员ID
 */
@property (strong, nonatomic) NSString *uid;

/**
 *  登录key
 */
@property (strong, nonatomic) NSString *session_key;

/**
 *  联票号码
 */
@property (strong, nonatomic) NSString *lpcode;

/**
 *  联票注册人姓名
 */
@property (strong, nonatomic) NSString *lpuser;

/**
 *  联票产品名称
 */
@property (strong, nonatomic) NSString *typename;

/**
 *  联票产品图片
 */
@property (strong, nonatomic) NSString *typepic;

/**
 *  有效期截至日期
 */
@property (strong, nonatomic) NSString *endtime;

/**
 *  注册时间
 */
@property (strong, nonatomic) NSString *regtime;

/**
 *  注册手机号
 */
@property (strong, nonatomic) NSString *mobile;

@end
