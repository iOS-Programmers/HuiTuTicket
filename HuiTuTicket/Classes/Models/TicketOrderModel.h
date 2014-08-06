//
//  TicketOrderModel.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketOrderModel : LXResultModel

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *scenicId;
@property (strong, nonatomic) NSString *scenicName;
@property (strong, nonatomic) NSString *traveltime;

@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *totalamount;
@property (strong, nonatomic) NSString *jiangjin;
@property (strong, nonatomic) NSString *paymode;

@property (strong, nonatomic) NSString *ispay;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *addtime;

@end

/*
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
*/