//
//  TicketOrderDetailPara.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketOrderDetailPara : LXParameterModel


@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *session_key;
@property (strong, nonatomic) NSString *orderid;
@property (strong, nonatomic) NSString *receive_moblie;

@property (strong, nonatomic) NSString *format;



@end

/*
 
 uid	否	会员ID	非会员预定时设置为空
 session_key	否	登录key	非会员预定时设置为空
 orderid	是	订单编号
 receive_moblie	否	取票人手机号	非会员查询时必须传递
 format	否	返回数据的格式	json或xml, get方式传递
 
 
 */