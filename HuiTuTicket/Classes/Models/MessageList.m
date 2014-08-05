//
//  MessageList.m
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "MessageList.h"

@implementation MessageList

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"MessageDetail" forKey:@"info"];
    }
    return self;
}

@end
