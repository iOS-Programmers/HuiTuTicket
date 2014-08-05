//
//  TicketScenicSpotList.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketScenicSpotList : LXResultModel

/**
 *  是否有下页  1-有 0-无
 */
@property (strong, nonatomic) NSString *hasnext;

/**
 *  页码
 */
@property (strong, nonatomic) NSString *page;

/**
 *  请求数量
 */
@property (strong, nonatomic) NSString *pagesize;

/**
 *  记录总数
 */
@property (strong, nonatomic) NSString *recordcount;

/**
 *  数组 包含消息详细信息
 */
@property (strong, nonatomic) NSMutableArray *info;

@end
