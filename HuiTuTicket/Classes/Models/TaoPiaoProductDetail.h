//
//  TaoPiaoProductDetail.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TaoPiaoProductDetail : LXResultModel

/**
 *  产品ID
 */
@property (strong, nonatomic) NSString *tpid;

/**
 *  标题
 */
@property (strong, nonatomic) NSString *title;

/**
 *  图片
 */
@property (strong, nonatomic) NSString *picture;

/**
 *  价格
 */
@property (strong, nonatomic) NSString *price;


/**
 *  预定说明
 */
@property (strong, nonatomic) NSString *ydsm;

/**
 *  产品说明
 */
@property (strong, nonatomic) NSString *content;


/**
 *  数组 包含详细信息
 */
@property (strong, nonatomic) NSMutableArray *scenicinfo;

@end
