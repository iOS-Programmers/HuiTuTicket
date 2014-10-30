//
//  MessageDetail.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface MessageDetail : LXResultModel

/**
 *  消息ID
 */
@property (strong, nonatomic) NSString *mid;

/**
 *  分类编号
 */
@property (strong, nonatomic) NSString *typeid;

/**
 *  消息标题
 */
@property (strong, nonatomic) NSString *title;

/**
 *  消息正文
 */
@property (strong, nonatomic) NSString *content;

/**
 *  发布时间
 */
@property (strong, nonatomic) NSString *addtime;

@end
