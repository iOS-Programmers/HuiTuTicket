//
//  LPTicketSearch.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface LPTicketSearch : LXResultModel

/**
 *  联票序列号
 */
@property (strong, nonatomic) NSString *codeNumber;

/**
 *  联票产品ID
 */
@property (strong, nonatomic) NSString *typeid;

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
 *  注册截止日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *reg_endtime;

/**
 *  使用截止日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *use_endtime;

/**
 *  使用有效期  单位：月。注册后有效期
 */
@property (strong, nonatomic) NSString *validitytime;

/**
 *  联票状态  0-正常 1-已注册 2-已过期
 */
@property (strong, nonatomic) NSString *state;

/**
 *  合作发行单位
 */
@property (strong, nonatomic) NSString *company;

/**
 *  使用说明
 */
@property (strong, nonatomic) NSString *direction;

@end
