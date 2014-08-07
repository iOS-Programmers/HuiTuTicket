//
//  LPTicketList.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LPTicketList.h"

@implementation LPTicketList


- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"LPTicket" forKey:@"info"];
    }
    return self;
}

@end
