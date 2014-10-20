//
//  HTLPIntroduceController.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/10/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseWebViewController.h"

@interface HTLPIntroduceController : HTBaseWebViewController

/**
 *  type 为1 联票介绍  为 2  获取联票  为 3 使用须知
 */
@property (copy, nonatomic) NSString *type;

@end
