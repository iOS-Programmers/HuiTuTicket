//
//  MessageListPara.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface MessageListPara : LXParameterModel

/**
 *  会员ID
 */
@property (strong, nonatomic) NSString *uid;

/**
 *  登录key
 */
@property (strong, nonatomic) NSString *session_key;

@end
