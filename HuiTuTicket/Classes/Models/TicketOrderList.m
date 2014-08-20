//
//  TicketOrderList.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketOrderList.h"

@implementation TicketOrderList

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"LPTicketOrderDetail" forKey:@"info"];
    }
    return self;
}

@end
