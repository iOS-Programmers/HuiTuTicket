//
//  TicketOrderQueryPara.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketOrderQueryPara : LXParameterModel


@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *session_key;
@property (strong, nonatomic) NSString *order_state;
@property (strong, nonatomic) NSString *page;

@property (strong, nonatomic) NSString *pagesize;
@property (strong, nonatomic) NSString *format;


@end

/*
 
 uid	是	会员ID
 session_key	是	登录key
 order_state	否	订单状态
 page	否	请求页码	默认为1
 pagesize	否	请求数量	每次请求返回数量，默认为20
 format	否	返回数据的格式	json或xml, get方式传递
 
 */
