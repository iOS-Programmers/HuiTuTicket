//
//  TicketScenicSpot.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketScenicSpot : LXResultModel

/**
 *  景区ID
 */
@property (strong, nonatomic) NSString *scenicId;

/**
 *  景区名称
 */
@property (strong, nonatomic) NSString *scenicName;

/**
 *  景区A级  整型，5表示为5A级 0为未评级
 */
@property (strong, nonatomic) NSString *rank;

/**
 *  景区代表图片
 */
@property (strong, nonatomic) NSString *picture;

/**
 *  所在省份
 */
@property (strong, nonatomic) NSString *province;

/**
 *  所在城市
 */
@property (strong, nonatomic) NSString *city;

/**
 *  景区地址
 */
@property (strong, nonatomic) NSString *address;

/**
 *  景区门票价格
 */
@property (strong, nonatomic) NSString *price;

/**
 *  游览时间限制  0-不限时 1-限时游览
 */
@property (strong, nonatomic) NSString *timelimit;

/**
 *  可游览起始日期  游览时间限制 格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *starttime;

/**
 *  可游览结束日期  游览时间限制 格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *endtime;

/**
 *  优惠方式  0-免票 1-优惠
 */
@property (strong, nonatomic) NSString *ptype;

/**
 *  优惠金额   非免票时优惠金额
 */
@property (strong, nonatomic) NSString *pmoney;

@end

/*
 
 
JSON格式：
{
	'state':'0',
	'data':{
		'hasnext': 1,
		'page': 1,
		'pagesize': 20,
		'recordcount': 1000,
		'info':[{
			'scenicId':1002,
			'scenicName':'云台山风景区',
			'rank':'5',
			'picture':'',
			'province':'河南',
			'city':'焦作',
			'address':'河南省焦作修武县云台山风景区',
			'price':210,
			'timelimit':0,
			'starttime': '',
			'endtime': '',
			'ptype': '0',
			'pmoney': '0'
		}]
	}
	'errcode':'0',
	'msg':'ok'
}
 
 */
