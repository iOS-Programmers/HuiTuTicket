//
//  HTMPOrderInfo.h
//  HuiTuTicket
//
//  Created by Bird on 14-9-11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface HTMPOrderInfo : LXResultModel

@property (copy, nonatomic) NSString *trade_no;
@property (copy, nonatomic) NSString *subject;
@property (copy, nonatomic) NSString *seller_id;
@property (copy, nonatomic) NSString *total_fee;
@property (copy, nonatomic) NSString *body;
@property (copy, nonatomic) NSString *notify_url;
@end

/*
 
 'trade_no'=>支付订单号,
 'subject'=>产品标题,
 'seller_id'=>'huitourvip@163.com',
 'total_fee'=>支付金额,
 'body'=>'',
 'notify_url'=>通知url
 
 */