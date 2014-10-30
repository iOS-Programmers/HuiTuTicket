//
//  LPTicket.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface LPTicket : LXResultModel

/**
 *  联票产品ID
 */
@property (strong, nonatomic) NSString *typeId;

/**
 *  联票产品名称
 */
@property (strong, nonatomic) NSString *lpName;

/**
 *  联票产品图片
 */
@property (strong, nonatomic) NSString *picurl;

/**
 *  包含景区数量
 */
@property (strong, nonatomic) NSString *scenic_num;

/**
 *  合作企业名称
 */
@property (strong, nonatomic) NSString *company;

@end
