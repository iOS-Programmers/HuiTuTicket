//
//  MyTicketList.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/10.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface MyTicketList : LXResultModel

/**
 *  是否有下页  1-有 0-无
 */
@property (strong, nonatomic) NSString *hasnext;

/**
 *  页码
 */
@property (strong, nonatomic) NSString *page;

/**
 *  请求数量
 */
@property (strong, nonatomic) NSString *pagesize;

/**
 *  记录总数
 */
@property (strong, nonatomic) NSString *recordcount;

/**
 *  数组 包含消息详细信息
 */
@property (strong, nonatomic) NSMutableArray *info;

/*

{
	'state':'0',
	'data':{
		'hasnext': 1,
		'page': 1,
		'pagesize': 20,
		'recordcount': 32,
		'info':[{
			'id': 103,
			'lpcode':'038110564856',
			'lpuser':'张三',
			'typename':'惠游河南',
			'typepic':'',
			'endtime':'2014-06-30',
			'regtime': '2013-07-02 15:28:30'
		}]
	}
	'errcode':'0',
	'msg':'ok'
}
*/

@end
