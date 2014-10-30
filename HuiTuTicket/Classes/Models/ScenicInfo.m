//
//  ScenicInfo.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "ScenicInfo.h"

@implementation ScenicInfo

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TaoPiaoTicket" forKey:@"ticket"];
    }
    return self;
}

@end
