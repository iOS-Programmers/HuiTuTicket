//
//  MyTicketPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface MyTicketPara : LXParameterModel

/**
 *  会员ID
 */
@property (strong, nonatomic) NSString *uid;

/**
 *  登录key
 */
@property (strong, nonatomic) NSString *session_key;

/**
 *  请求页码  默认为1  *非必传
 */
@property (strong, nonatomic) NSString *page;

/**
 *  请求数量  每次请求返回数量，默认为20  *非必传
 */
@property (strong, nonatomic) NSString *pagesize;

@end
