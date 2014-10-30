//
//  LPTicketList.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface LPTicketList : LXResultModel


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

@end

/*
{
	'state':'0',
	'data':{
		'hasnext': 1,
		'page': 1,
		'pagesize': 20,
		'recordcount': 1000,
		'info':[{
			'typeId':316,
			'lpName':'惠游河南',
			'picurl':'',
			'scenic_num': 206,
			'company':'河南邮政集团'
		}]
	}
	'errcode':'0',
	'msg':'ok'
}
*/
