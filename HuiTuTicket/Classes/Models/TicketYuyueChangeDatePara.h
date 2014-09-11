//
//  TicketYuyueChangeDatePara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketYuyueChangeDatePara : LXParameterModel

/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codenumber;

/**
 *  预约记录ID
 */
@property (strong, nonatomic) NSString *orderid;

/**
 *  出游日期 格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *time;

@end
