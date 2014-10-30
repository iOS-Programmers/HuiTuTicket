//
//  TaoPiaoTicket.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TaoPiaoTicket : LXResultModel

@property (strong, nonatomic) NSString *ticketId;
@property (strong, nonatomic) NSString *ticketName;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *num;

@end
