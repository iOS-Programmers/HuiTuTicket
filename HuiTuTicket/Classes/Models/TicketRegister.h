//
//  TicketRegister.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketRegister : LXResultModel

/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codenumber;

/**
 *  注册人姓名
 */
@property (strong, nonatomic) NSString *username;

/**
 *  联票产品ID
 */
@property (strong, nonatomic) NSString *typeid;

/**
 *  联票产品名称
 */
@property (strong, nonatomic) NSString *lpName;

/**
 *  联票产品图片
 */
@property (strong, nonatomic) NSString *picurl;

/**
 *  有效期截至日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *endtime;

/**
 *  注册时间  格式YYYY-MM-DD HH:mm:ss
 */
@property (strong, nonatomic) NSString *regtime;

@end
