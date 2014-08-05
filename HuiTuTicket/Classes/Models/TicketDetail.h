//
//  TicketDetail.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketDetail : LXResultModel

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
 *  可游览景区数量
 */
@property (strong, nonatomic) NSString *scenic_num;

/**
 *  注册截止日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *reg_endtime;

/**
 *  使用截止日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *use_endtime;

/**
 *  使用有效期  单位：月。注册后有效期
 */
@property (strong, nonatomic) NSString *validitytime;

/**
 *  合作发行单位
 */
@property (strong, nonatomic) NSString *company;

/**
 *  使用说明
 */
@property (strong, nonatomic) NSString *direction;

/*
JSON格式：
{
	'state':'0',
	'data':{
		'typeid':6,
		'lpName':'惠游河南',
		'picurl':'',
		'scenic_num': 206,
		'reg_endtime':'2014-06-30',
		'use_endtime': '2015-06-30',
		'validitytime': 12,
		'company':'河南邮政集团',
		'direction':'使用说明'
	},
	'errcode':'0',
	'msg':'ok'
}
*/
@end
