//
//  TicketYuyueScenicList.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketYuyueScenicList.h"

@implementation TicketYuyueScenicList
- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TicketScenicSpot" forKey:@"info"];
    }
    return self;
}

@end
