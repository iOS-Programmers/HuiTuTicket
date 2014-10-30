//
//  TicketOrderListPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketOrderListPara : LXParameterModel

/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codenumber;

/**
 *  注册人姓名
 */
@property (strong, nonatomic) NSString *username;

@end
