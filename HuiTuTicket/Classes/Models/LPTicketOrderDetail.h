//
//  LPTicketOrderDetail.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface LPTicketOrderDetail : LXResultModel

/**
 *  预约记录ID
 */
@property (strong, nonatomic) NSString *orderid;

/**
 *  联票号码
 */
@property (strong, nonatomic) NSString *codeNumber;

/**
 *  景区名称
 */
@property (strong, nonatomic) NSString *scenicName;

/**
 *  预约出游日期
 */
@property (strong, nonatomic) NSString *traveltime;

/**
 *  预约状态  0-未出游 1-已出游
 */
@property (strong, nonatomic) NSString *state;

/**
 *  预约下单时间
 */
@property (strong, nonatomic) NSString *addtime;

@end

/*
'info':[{
    'orderid': 1832,
    'codeNumber':'238106577062',
    'scenicName':'云台山风景区',
    'traveltime': '2014-05-26',
    'state':0,
    'addtime': '2014-05-20 15:28:30',
}]
*/
