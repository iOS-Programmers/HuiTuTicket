//
//  ScenicDetail.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface ScenicDetail : LXResultModel
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *data;
@property (strong, nonatomic) NSString *scenicId;
@property (strong, nonatomic) NSString *scenicName;

@property (strong, nonatomic) NSString *rank;
@property (strong, nonatomic) NSString *picture;
@property (strong, nonatomic) NSString *province;
@property (strong, nonatomic) NSString *city;

@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *zhuti;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *minprice;

@property (strong, nonatomic) NSString *opentime;
@property (strong, nonatomic) NSString *intro;
@property (strong, nonatomic) NSString *orderlimit;
@property (strong, nonatomic) NSString *pingzheng;

@property (strong, nonatomic) NSString *qupiao;
@property (strong, nonatomic) NSString *youhui;
@property (strong, nonatomic) NSString *tishi;
@property (strong, nonatomic) NSString *jiaotong;

@property (strong, nonatomic) NSString *meishi;
@property (strong, nonatomic) NSString *gouwu;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *lng;

@property (strong, nonatomic) NSString *lat;


@end

/*
 
 {
 'state':'0',
 'data':{
 'scenicId':1002,
 'scenicName':'云台山风景区',
 
 'rank':'5',
 'picture':'',
 'province':'河南',
 'city':'焦作',
 
 'address':'河南省焦作修武县云台山风景区',
 'zhuti':'自然风光',
 'price':210,
 'minprice':180,
 
 'opentime':'8:30--17:30',
 'intro':'简介',
 'orderlimit':'预定限制',
 'pingzheng':'入园凭证',
 
 'qupiao':'取票地点',
 'youhui':'景区优惠政策',
 'tishi':'温馨提示',
 'jiaotong':'交通指南',
 
 'meishi':'美食',
 'gouwu':'购物',
 'content':'详细介绍',
 'lng':113.600737,
 
 'lat':35.409093
 },
 'errcode':'0',
 'msg':'ok'
 }
 
 */