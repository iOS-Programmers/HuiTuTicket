//
//  TicketYuyueScenicListPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketYuyueScenicListPara : LXParameterModel

/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codenumber;

/**
 *  注册人姓名
 */
@property (strong, nonatomic) NSString *username;

/**
 *  景区名称关键字 *非必须
 */
@property (strong, nonatomic) NSString *scenicname;

/**
 *  景区名称关键字 *非必须
 */
@property (strong, nonatomic) NSString *orderid;

/**
 *  页码 *非必须
 */
@property (strong, nonatomic) NSString *page;

/**
 *  请求数量 *非必须
 */
@property (strong, nonatomic) NSString *pagesize;

/**
 *  排序 *非必须
 */
@property (strong, nonatomic) NSString *orderby;

@end
