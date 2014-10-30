//
//  TicketScenicSpotListPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TicketScenicSpotListPara : LXParameterModel

/**
 *  联票产品ID
 */
@property (strong, nonatomic) NSString *typeid;

/**
 *  景区名称关键字 *非必传
 */
@property (strong, nonatomic) NSString *scenicname;

/**
 *  请求页码  *非必传  默认为1
 */
@property (strong, nonatomic) NSString *page;

/**
 *  请求数量 *非必传  每次请求返回数量，默认为20
 */
@property (strong, nonatomic) NSString *pagesize;

/**
 *  排序
 */
@property (strong, nonatomic) NSString *orderby;


@end
