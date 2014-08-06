//
//  TicketOrderQuery.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"
#import "TicketOrderModel.h"
@interface TicketOrderQuery : LXResultModel

@property (strong, nonatomic) NSString *hasnext;
@property (strong, nonatomic) NSString *page;
@property (strong, nonatomic) NSString *pagesize;
@property (strong, nonatomic) NSString *recordcount;

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
         'orderId':'2013070116362312346',
         'scenicId':1002,
         'scenicName':'云台山风景区',
         'traveltime':'2013-07-25',
         'number':1,
         'totalamount': 160,
         'jiangjin': 5,
         'paymode': '0',
         'ispay': '0',
         'status':'1',
         'addtime':'2013-07-01'
        }]
 }
 'errcode':'0',
 'msg':'ok'
 }
 
 */