//
//  ScenicTicket.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "ScenicTicket.h"

@implementation ScenicTicket
- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TicketModel" forKey:@"dataArray"];
    }
    return self;
}
@end
