//
//  ScenicList.m
//  HuiTuTicket
//
//  Created by Bird on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "ScenicList.h"

@implementation ScenicList
- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"Scenic" forKey:@"info"];
    }
    return self;
}

@end
