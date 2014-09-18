//
//  TPOrderDetail.m
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TPOrderDetail.h"

@implementation TPOrderDetail
- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"ScenicInfo" forKey:@"scenicinfo"];
    }
    return self;
}

@end
