//
//  HTFoundationCommon.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTFoundationCommon : NSObject

/** check if object is empty
 if an object is nil, NSNull, or length == 0, return True
 */
static inline BOOL FBIsEmpty(id thing)
{
    return thing == nil ||
    ([thing isEqual:[NSNull null]]) ||
    ([thing respondsToSelector:@selector(length)] && [(NSData *)thing length] == 0) ||
    ([thing respondsToSelector:@selector(count)]  && [(NSArray *)thing count] == 0);
}

+ (CGFloat)getAdapterHeight;

/**
 *  MD5加密 （32位小写）
 *
 *  @param str 传入的字符串
 *
 *  @return 经过md5加密后的字符串
 */
+ (NSString *)md5:(NSString *)str;

/**
 *  检测网络状态
 *
 */
+ (BOOL)networkDetect;

/**
 *  获取校验秘钥 默认123

 */
+(NSString *)getAPI_KEY;




@end
