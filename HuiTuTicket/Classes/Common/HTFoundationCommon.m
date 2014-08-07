//
//  HTFoundationCommon.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTFoundationCommon.h"
#import <CommonCrypto/CommonDigest.h>


@implementation HTFoundationCommon

+ (CGFloat)getAdapterHeight {
    CGFloat adapterHeight = 0;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 7.0) {
        adapterHeight = 44;
    }
    return adapterHeight;
}

/**
 *  MD5加密 （32位小写）
 *
 *  @param str 传入的字符串
 *
 *  @return 经过md5加密后的字符串
 */
+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    
    CC_MD5( cStr, strlen(cStr), result );

//    return [NSString stringWithFormat:
//            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
    return [NSString stringWithFormat:
            @"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
    
            result[0],result[1],result[2],result[3],
            
            result[4],result[5],result[6],result[7],
            
            result[8],result[9],result[10],result[11],
            
            result[12],result[13],result[14],result[15],
            
            result[16], result[17],result[18], result[19],
            
            result[20], result[21],result[22], result[23],
            
            result[24], result[25],result[26], result[27],
            
            result[28], result[29],result[30], result[31]];
}

/**
 *  检测网络状态
 *
 *  @return 网络状态
 */
+ (BOOL)networkDetect
{
    BOOL isExistenceNetwork = YES;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus])
    {
        case NotReachable:
            isExistenceNetwork = NO;
            LXLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            isExistenceNetwork = YES;
            LXLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork = YES;
            LXLog(@"正在使用wifi网络");
            break;
    }
    return  isExistenceNetwork;
    
}


/**
 *  获取校验秘钥 默认123
 *
 *  @return
 */
+(NSString *)getAPI_KEY
{
    return @"123";
}

@end
