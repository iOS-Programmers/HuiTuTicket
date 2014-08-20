//
//  MyTicketDetailInfo.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface MyTicketDetailInfo : LXResultModel

/**
 *  联票号码
 */
@property (strong, nonatomic) NSString *codeNumber;

/**
 *  注册人
 */
@property (strong, nonatomic) NSString *username;

/**
 *  证件类型  0-身份证 1-军官证
 */
@property (strong, nonatomic) NSString *idtype;

/**
 *  证件号码
 */
@property (strong, nonatomic) NSString *idcard;

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
 *  注册日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *regtime;

/**
 *  截止日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *endtime;

/**
 *  使用说明
 */
@property (strong, nonatomic) NSString *direction;

@end
/*
{
	'state':'0',
	'data':{
		'codeNumber':'238106577062',
		'username': '张三',
		'idtype': 0,
		'idcard': '410101000000000000',
		'typeid':6,
		'lpName':'惠游河南',
		'picurl':'',
		'scenic_num':206,
		'endtime':'2015-06-30',
		'regtime':'2014-05-30 15:30:28',
		'direction':'使用说明'
	},
	'errcode':'0',
	'msg':'ok'
}
 */
