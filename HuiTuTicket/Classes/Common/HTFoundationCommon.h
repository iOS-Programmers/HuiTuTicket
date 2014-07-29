//
//  HTFoundationCommon.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HTFoundationCommon : NSObject

+ (CGFloat)getAdapterHeight;

/**
 *  MD5加密 （32位小写）
 *
 *  @param str 传入的字符串
 *
 *  @return 经过md5加密后的字符串
 */
+ (NSString *)md5:(NSString *)str;

@end
