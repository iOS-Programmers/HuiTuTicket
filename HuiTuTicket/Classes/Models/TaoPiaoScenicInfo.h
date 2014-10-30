//
//  TaoPiaoScenicInfo.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TaoPiaoScenicInfo : LXResultModel

@property (strong, nonatomic) NSString *scenicId;
@property (strong, nonatomic) NSString *scenicName;
@property (strong, nonatomic) NSMutableArray *ticket;

@end
