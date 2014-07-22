//
//  HTStoreManager.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTStoreManager.h"

@implementation HTStoreManager

+ (instancetype)shareStoreManager
{
    static HTStoreManager *storeManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        storeManager = [[HTStoreManager alloc] init];
    });
    return storeManager;
}

- (NSMutableArray *)getMoreConfigureArray
{
    NSMutableArray *moreConfigureArray = [[NSMutableArray alloc] initWithCapacity:3];
    
    NSDictionary *settingDic = @{@"title": @"设置",@"image": @"more_setting"};
    [moreConfigureArray addObject:@[settingDic]];
    
    NSDictionary *qrcodeDic = @{@"title": @"扫一扫",@"image": @"more_qcore"};
    NSDictionary *feedbackDic = @{@"title": @"意见反馈",@"image": @"more_feedback"};
    NSDictionary *helpCenterDic = @{@"title": @"帮助中心",@"image": @"more_helpcenter"};
    [moreConfigureArray addObject:@[qrcodeDic,feedbackDic,helpCenterDic]];
    
    
    NSDictionary *scoreDic = @{@"title": @"给我评分",@"image": @"more_score"};
    [moreConfigureArray addObject:@[scoreDic]];
    
    NSDictionary *checkUpdateDic = @{@"title": @"检查更新",@"image": @"more_update"};
    NSDictionary *aboutUsDic = @{@"title": @"关于我们",@"image": @"more_aboutus"};
    [moreConfigureArray addObject:@[checkUpdateDic,aboutUsDic]];
    
    return moreConfigureArray;
}

- (NSMutableArray *)getMineConfigureArray
{
    NSMutableArray *mineConfigureArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    NSDictionary *myTicketDic = @{@"title": @"我的联票",@"image": @"my_01"};
    [mineConfigureArray addObject:@[myTicketDic]];
    
    NSDictionary *myScoreDic = @{@"title": @"我的积分",@"image": @"my_02"};
    NSDictionary *myBonusDic = @{@"title": @"我的奖金",@"image": @"my_03"};
    NSDictionary *myRedPacketDic = @{@"title": @"我的红包",@"image": @"my_04"};
    [mineConfigureArray addObject:@[myScoreDic,myBonusDic,myRedPacketDic]];
    
    
    NSDictionary *myCollectDic = @{@"title": @"我的收藏",@"image": @"my_05"};
    NSDictionary *myCommentDic = @{@"title": @"我的点评",@"image": @"my_06"};
    [mineConfigureArray addObject:@[myCollectDic,myCommentDic]];
    
    return mineConfigureArray;
}

- (NSMutableArray *)getOrderConfigureArray
{
    NSMutableArray *orderConfigureArray = [[NSMutableArray alloc] initWithCapacity:2];
    
    NSDictionary *waitCommentDic = @{@"title": @"待点评订单",@"image": @"order_01"};
    [orderConfigureArray addObject:@[waitCommentDic]];
    
    NSDictionary *ticketDic = @{@"title": @"景区门票订单",@"image": @"order_02"};
    NSDictionary *hotelDic = @{@"title": @"酒店订单",@"image": @"order_03"};
    NSDictionary *airTicketDic = @{@"title": @"机票订单",@"image": @"order_04"};
    NSDictionary *freeTraveDic = @{@"title": @"自由行订单",@"image": @"order_05"};
    [orderConfigureArray addObject:@[ticketDic,hotelDic,airTicketDic,freeTraveDic]];
    
    return orderConfigureArray;
}

@end
