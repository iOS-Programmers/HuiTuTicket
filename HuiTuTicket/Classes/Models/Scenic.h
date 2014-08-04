//
//  Scenic.h
//  HuiTuTicket
//
//  Created by Bird on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface Scenic : LXResultModel

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
@property (strong, nonatomic) NSString *lng;
@property (strong, nonatomic) NSString *lat;

@property (strong, nonatomic) NSString *updatetime;


@end


/*
 
 'scenicId': 1002,
 'scenicName': '云台山风景区',
 'rank': '5',
 'picture': '',
 'province': '河南',
 'city': '焦作',
 'address': '河南省焦作修武县云台山风景区',
 'zhuti': '自然风光',
 'price': 210,
 'minprice': 180,
 'lng': 113.600737,
 'lat': 35.409093,
 'updatetime': '2013-06-25 15:23:16'
 
 */