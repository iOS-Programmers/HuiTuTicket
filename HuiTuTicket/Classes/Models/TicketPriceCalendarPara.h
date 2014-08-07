//
//  TicketPriceCalendarPara.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketPriceCalendarPara : LXParameterModel

@property (strong, nonatomic) NSString *ticketid;
@property (strong, nonatomic) NSString *tm;
@property (strong, nonatomic) NSString *format;


@end

/*
 
 ticketid	是	门票ID
 tm	否	月份	格式YYYYMM 如：201309，默认当月
 format	否	返回数据的格式	json或xml, get方式传递
 
 */