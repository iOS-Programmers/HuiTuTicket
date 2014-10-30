//
//  MessageNotice.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface MessageNotice : LXResultModel

/**
 *  获取新消息数量
 */
@property (strong, nonatomic) NSString *count;

@end
