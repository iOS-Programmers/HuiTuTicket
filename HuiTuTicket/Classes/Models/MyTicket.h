//
//  MyTicket.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface MyTicket : LXResultModel

/**
 *  联票产品ID
 */
@property (strong, nonatomic) NSString *id;

/**
 *  联票号码
 */
@property (strong, nonatomic) NSString *lpcode;

/**
 *  注册人姓名
 */
@property (strong, nonatomic) NSString *lpuser;

/**
 *  联票产品名称
 */
@property (strong, nonatomic) NSString *typename;

/**
 *  联票产品图片
 */
@property (strong, nonatomic) NSString *typepic;

/**
 *  使用截止日期  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *endtime;

/**
 *  注册时间  格式YYYY-MM-DD
 */
@property (strong, nonatomic) NSString *regtime;

@end

/*
'info':[{
    'id': 103,
    'lpcode':'038110564856',
    'lpuser':'张三',
    'typename':'惠游河南',
    'typepic':'',
    'endtime':'2014-06-30',
    'regtime': '2013-07-02 15:28:30'
}]
*/