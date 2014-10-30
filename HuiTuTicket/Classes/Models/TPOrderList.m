//
//  TPOrderList.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TPOrderList.h"

@implementation TPOrderList
- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TPOrder" forKey:@"info"];
    }
    return self;
}
@end
