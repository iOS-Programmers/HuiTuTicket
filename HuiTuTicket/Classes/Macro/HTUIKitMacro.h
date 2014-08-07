//
//  HTUIKitMacro.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#ifndef HuiTuTicket_HTUIKitMacro_h
#define HuiTuTicket_HTUIKitMacro_h

#define kLOADING_TEXT  @"加载中.."

#define kNETWORK_ERROR @"网络连接有误,请检查网络"

#define kSERVICE_ERROR @"暂时连不上服务器,请稍后再试"



//部分常用颜色
#define kColorClear         [UIColor clearColor]
#define kColorWhite         [UIColor whiteColor]
#define kColorBlack         [UIColor blackColor]
#define kColorYellow        [UIColor yellowColor]
#define kColorBlue          [UIColor blueColor]
#define kColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define kColorRGB(r,g,b)    [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]
#define kColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kBorderColor        kColorFromRGB(0xcccccc)
#define kHomeBGColor        kColorRGB(229, 233, 239)



#pragma mark -   NSUserDefault Names

#define USER_INFO   @"userInfo"

#endif
