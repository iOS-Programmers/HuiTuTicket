//
//  TaoPiaoProduct.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TaoPiaoProduct : LXResultModel

/**
 *  产品编号
 */
@property (strong, nonatomic) NSString *tpid;

/**
 *  产品名
 */
@property (strong, nonatomic) NSString *title;

/**
 *  图片
 */
@property (strong, nonatomic) NSString *picture;

/**
 *  预定起价
 */
@property (strong, nonatomic) NSString *minprice;

/**
 *  更新时间
 */
@property (strong, nonatomic) NSString *updatetime;

@end
