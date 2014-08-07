//
//  TicketOrderQuery.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketOrderQuery.h"

@implementation TicketOrderQuery
- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TicketOrderModel" forKey:@"info"];
    }
    return self;
}

@end
