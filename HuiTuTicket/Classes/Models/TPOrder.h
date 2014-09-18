//
//  TPOrder.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TPOrder : LXResultModel
@property (copy, nonatomic) NSString *orderId;
@property (copy, nonatomic) NSString *tpid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *traveltime;
@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *totalamount;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *addtime;

@end
/*
 
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