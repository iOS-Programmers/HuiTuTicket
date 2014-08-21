//
//  HTStoreManager.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HTStoreManager : NSObject

+ (instancetype)shareStoreManager;

/**
 *  配置<更多界面>cell里的内容（文字和图片）
 *
 *  @return 返回数组
 */
- (NSMutableArray *)getMoreConfigureArray;

/**
 *  配置<我的页面>cell里的内容
 *
 *  @return 包含图片和标题的数组
 */
- (NSMutableArray *)getMineConfigureArray;

/**
 *  配置<订单页面>cell里的内容
 *
 *  @return 包含图片和标题的数组
 */
- (NSMutableArray *)getOrderConfigureArray;

/**
 *  配置<关于我们>cell里的内容
 *
 *  @return 包含标题的数组
 */
- (NSMutableArray *)getAboutUsConfigureArray;

@end
