//
//  TPOrderList.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"
#import "TPOrder.h"
@interface TPOrderList : LXResultModel

@property (copy, nonatomic) NSString *hasnext;
@property (copy, nonatomic) NSString *page;
@property (copy, nonatomic) NSString *pagesize;
@property (copy, nonatomic) NSString *recordcount;
@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSMutableArray *info;






@end


/*
 
 'hasnext': 1,
 'page': 1,
 'pagesize': 20,
 'recordcount': 1000,
 'info':[{
 'orderId':'2013070116362312346',
 'tpid':1832,
 'title':'云台山风景区成人票2张+青天河门票2张',
 'traveltime':'2013-07-25',
 'number':1,
 'totalamount': 160,
 'status':1,
 'addtime':'2013-07-01'
 }]
 
 
 */