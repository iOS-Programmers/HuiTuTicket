//
//  TaoPiaoProductDetail.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TaoPiaoProductDetail.h"

@implementation TaoPiaoProductDetail

- (id)init
{
    self = [super init];
    if (nil != self){
        [self.objMapDic setObject:@"TaoPiaoScenicInfo" forKey:@"scenicinfo"];
    }
    return self;
}


@end
