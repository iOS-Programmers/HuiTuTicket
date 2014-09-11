//
//  TicketYuyueSubmitPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/12.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketYuyueSubmitPara : LXParameterModel

/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codenumber;

/**
 *  注册人姓名
 */
@property (strong, nonatomic) NSString *username;

/**
 *  预约景区ID
 */
@property (strong, nonatomic) NSString *scenicid;

/**
 *  出游日期 格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *time;

@end
