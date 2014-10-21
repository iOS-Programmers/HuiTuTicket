//
//  TaoPiaoScenicInfo.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TaoPiaoScenicInfo.h"
#import "TaoPiaoTicket.h"

@implementation TaoPiaoScenicInfo

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TaoPiaoTicket" forKey:@"ticket"];
    }
    return self;
}

@end
