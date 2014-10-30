//
//  HomeBanner.m
//  HuiTuTicket
//
//  Created by Bird on 14-8-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HomeBanner.h"

@implementation HomeBanner

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"Banner" forKey:@"dataArray"];
    }
    return self;
}

@end
