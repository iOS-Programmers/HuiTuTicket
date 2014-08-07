//
//  TicketOrderDetail.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketOrderDetail : LXResultModel

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *scenicId;
@property (strong, nonatomic) NSString *scenicName;
@property (strong, nonatomic) NSString *ticketId;

@property (strong, nonatomic) NSString *ticketName;
@property (strong, nonatomic) NSString *receivername;
@property (strong, nonatomic) NSString *receivermoblie;
@property (strong, nonatomic) NSString *traveltime;


@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *totalamount;
@property (strong, nonatomic) NSString *jiangjin;
@property (strong, nonatomic) NSString *paymode;

@property (strong, nonatomic) NSString *ispay;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *qupiao;

@property (strong, nonatomic) NSString *opentime;
@property (strong, nonatomic) NSString *addtime;




@end


/*
 
 {
 'state':'0',
 'data':{
     'orderId':'2013070116362312346',
     'scenicId':1002,
     'scenicName':'云台山风景区',
     'ticketId':10382,
 
     'ticketName':'云台山 成人票',
     'receivername':'张三',
     'receivermoblie':'13800138000',
     'traveltime':'2013-07-25',
 
     'number':1,
     'totalamount': 160,
     'jiangjin': 5,
     'paymode': '0',
 
     'ispay': '0',
     'status':'1',
     'address':'景区地址',
     'qupiao':'取票地点',
     'opentime':'开放时间',
     'addtime':'2013-07-01'
     }
 'errcode':'0',
 'msg':'ok'
 }
 
 */