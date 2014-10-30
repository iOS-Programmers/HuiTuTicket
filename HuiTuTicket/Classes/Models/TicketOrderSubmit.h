//
//  TicketOrderSubmit.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketOrderSubmit : LXResultModel

@property (strong, nonatomic) NSString *orderId;
@property (strong, nonatomic) NSString *scenicId;
@property (strong, nonatomic) NSString *scenicName;
@property (strong, nonatomic) NSString *ticketId;

@property (strong, nonatomic) NSString *ticketName;
@property (strong, nonatomic) NSString *totalamount;
@property (strong, nonatomic) NSString *paymode;
@property (strong, nonatomic) NSString *qupiao;


@end
/*
 
 'data':{
 'orderId':'2013070116362312346',
 'scenicId':1002,
 'scenicName':'云台山风景区',
 'ticketId':10382,
 
 'ticketName':'云台山 成人票',
 'totalamount': 160,
 'paymode': '0',
 'qupiao':'取票地点'
 }
 
 */