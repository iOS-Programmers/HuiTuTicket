//
//  TicketYuYueDetail.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketYuYueDetail : LXResultModel

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *codeNumber;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *idtype;

@property (strong, nonatomic) NSString *idcard;
@property (strong, nonatomic) NSString *traveltime;
@property (strong, nonatomic) NSString *scenicId;
@property (strong, nonatomic) NSString *scenicName;


@property (strong, nonatomic) NSString *rank;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *timelimit;
@property (strong, nonatomic) NSString *starttime;

@property (strong, nonatomic) NSString *endtime;
@property (strong, nonatomic) NSString *ptype;
@property (strong, nonatomic) NSString *pmoney;
@property (strong, nonatomic) NSString *state;


@end

/*
{
	'state':'0',
	'data':{
		'orderId': 1832,
		'codeNumber':'238106577062',
		'username': '张三',
		'idtype': 0,
		'idcard': '410101000000000000',
		'traveltime': '2014-06-30',
		'scenicId':1002,
		'scenicName':'云台山风景区',
        'rank':'5',
        'address':'河南省焦作修武县云台山风景区',
        'timelimit':0,
        'starttime': '',
        'endtime': '',
        'ptype': '0',
        'pmoney': '0',
        'state':0
        },
    'errcode':'0',
    'msg':'ok'
}
*/