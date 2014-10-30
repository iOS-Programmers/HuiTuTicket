//
//  TPOrderDetail.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"
#import "ScenicInfo.h"

@interface TPOrderDetail : LXResultModel

@property (copy, nonatomic) NSString *orderId;
@property (copy, nonatomic) NSString *traveltime;
@property (copy, nonatomic) NSString *tpid;
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *receivername;
@property (copy, nonatomic) NSString *receivermoblie;
@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *totalamount;
@property (copy, nonatomic) NSString *jiangjin;
@property (copy, nonatomic) NSString *ispay;
@property (copy, nonatomic) NSString *status;
@property (copy, nonatomic) NSString *addtime;
@property (strong, nonatomic) NSMutableArray *scenicinfo;





@end
/*
 
 'data':{
 'orderId':'2013070116362312346',
 'tpid':1832,
 'title':'云台山风景区成人票2张+青天河门票2张',
 'receivername':'张三',
 'receivermoblie':'13800138000',
 'number':1,
 'totalamount': 160,
 'jiangjin': 5,
 'ispay': '0',
 'status':'1',
 'addtime':'2013-07-01',
 'scenicinfo':[{
 'scenicId':1002,
 'scenicName':'云台山风景区',
 'traveltime':'2014-8-15',
 'ticket':[{
 'ticketId': 2835,
 'ticketName':'成人票',
 'price':180,
 'num': 2
 }]
 },
 {
 'scenicId':1203,
 'scenicName':'青天河风景区',
 'traveltime':'2014-8-16',
 'ticket':[{
 'ticketId': 3285,
 'ticketName':'成人票',
 'price':80,
 'num': 2
 }]
 }]
 
 }
 
 
 */