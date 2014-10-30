//
//  ScenicTicket.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"
#import "TicketModel.h"

@interface ScenicTicket : LXResultModel

@property (strong, nonatomic) NSMutableArray *dataArray;

@end
/*
 
 {
 'state':'0',
 'data':[{
 'ticketId':10382,
 'ticketName':'云台山 成人票',
 
 'typeid':1,
 'people':'1',
 'price':'210',
 'bookprice':'160',
 
 'jiangjin':'5',
 'paymode':'0',
 'maxnum':'0',
 'minnum':'1',
 
 'notice':'包含景区内交通费',
 'updatetime':'2013-06-25 15:23:16'
 }],
 'errcode':'0',
 'msg':'ok'
 }
 
 */