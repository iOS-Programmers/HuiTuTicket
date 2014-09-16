//
//  TaoPiaoProductList.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TaoPiaoProductList.h"

@implementation TaoPiaoProductList

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TaoPiaoProduct" forKey:@"info"];
    }
    return self;
}

@end
