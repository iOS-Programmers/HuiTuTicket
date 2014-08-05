//
//  TicketScenicSpotList.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketScenicSpotList.h"

@implementation TicketScenicSpotList


- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TicketScenicSpot" forKey:@"info"];
    }
    return self;
}


@end
