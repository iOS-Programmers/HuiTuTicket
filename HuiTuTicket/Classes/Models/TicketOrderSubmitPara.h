//
//  TicketOrderSubmitPara.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketOrderSubmitPara : LXParameterModel


@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *session_key;
@property (strong, nonatomic) NSString *scenicid;
@property (strong, nonatomic) NSString *ticketid;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *travel_time;
@property (strong, nonatomic) NSString *receive_name;
@property (strong, nonatomic) NSString *receive_moblie;
@property (strong, nonatomic) NSString *app_ver;
@property (strong, nonatomic) NSString *sig;


@property (strong, nonatomic) NSString *format;





@end


/*
 
 uid	否	会员ID	非会员预定时设置为空
 session_key	否	登录key	非会员预定时设置为空
 scenicid	是	景区ID
 ticketid	是	门票ID
 number	是	预定数量
 travel_time	是	预定出游时间
 receive_name	是	取票人姓名
 receive_moblie	是	取票人手机号
 app_ver	否	APP版本号	取值示例IOS_v1.0或Android_v1.0.1
 sig	是	参数MD5校验串	参见设计说明
 format	否	返回数据的格式	json或xml, get方式传递
 
 
 */