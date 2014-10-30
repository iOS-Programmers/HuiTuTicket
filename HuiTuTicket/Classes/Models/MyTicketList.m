//
//  MyTicketList.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/10.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "MyTicketList.h"

@implementation MyTicketList

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"MyTicket" forKey:@"info"];
    }
    return self;
}

@end
