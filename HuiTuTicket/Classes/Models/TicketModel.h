//
//  TicketModel.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"

@interface TicketModel : LXResultModel

@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *data;
@property (strong, nonatomic) NSString *ticketId;
@property (strong, nonatomic) NSString *ticketName;

@property (strong, nonatomic) NSString *typeId;
@property (strong, nonatomic) NSString *people;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *bookprice;

@property (strong, nonatomic) NSString *jiangjin;
@property (strong, nonatomic) NSString *paymode;
@property (strong, nonatomic) NSString *maxnum;
@property (strong, nonatomic) NSString *minnum;

@property (strong, nonatomic) NSString *notice;
@property (strong, nonatomic) NSString *updatetime;

@end
