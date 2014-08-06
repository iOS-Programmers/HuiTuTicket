//
//  ScenicList.h
//  HuiTuTicket
//
//  Created by Bird on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"
#import "Scenic.h"

@interface ScenicList : LXResultModel

@property (strong, nonatomic) NSString *hasnext;
@property (strong, nonatomic) NSString *page;
@property (strong, nonatomic) NSString *pagesize;
@property (strong, nonatomic) NSString *recordcount;
@property (strong, nonatomic) NSMutableArray *info;





@end


/*
 
 'data': {
 'hasnext': 1,
 'page': 1,
 'pagesize': 20,
 'recordcount': 1000,
 'info': 
    [{
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
     } ]
 }
 
 */