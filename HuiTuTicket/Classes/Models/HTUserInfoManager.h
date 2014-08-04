//
//  HTUserInfoManager.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  储存项目中用户相关信息的类 （调用的时候用单例模式调用）
 */
@interface HTUserInfoManager : NSObject

+ (instancetype)shareInfoManager;
@end
