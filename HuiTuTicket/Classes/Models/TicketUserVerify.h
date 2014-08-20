//
//  TicketUserVerify.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketUserVerify : LXResultModel

/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codeNumber;

/**
 *  注册人姓名
 */
@property (strong, nonatomic) NSString *username;

/**
 *  联票产品ID
 */
@property (strong, nonatomic) NSString *typeid;

/**
 *  联票名称
 */
@property (strong, nonatomic) NSString *lpName;

/**
 *  联票产品图片
 */
@property (strong, nonatomic) NSString *picurl;

/**
 *  截止日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *endtime;
/**
 *  注册时间  格式YYYY-MM-DD HH:mm:ss
 */
@property (strong, nonatomic) NSString *regtime;



@end
