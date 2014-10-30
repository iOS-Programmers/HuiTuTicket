//
//  TicketOrderList.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketOrderList : LXResultModel

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
		'recordcount': 65,
		'info':[{
			'orderid': 1832,
			'codeNumber':'238106577062',
			'scenicName':'云台山风景区',
			'traveltime': '2014-05-26',
			'state':0,
			'addtime': '2014-05-20 15:28:30',
		}]
	}
	'errcode':'0',
	'msg':'ok'
}
*/
