//
//  ScenicInfo.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXResultModel.h"
#import "TaoPiaoTicket.h"

@interface ScenicInfo : LXResultModel
@property (copy, nonatomic) NSString *scenicId;
@property (copy, nonatomic) NSString *scenicName;
@property (copy, nonatomic) NSString *traveltime;
@property (strong, nonatomic) NSMutableArray *ticket;




@end
/*
 
 'scenicId':1002,
 'scenicName':'云台山风景区',
 'traveltime':'2014-8-15',
 'ticket':[{
 'ticketId': 2835,
 'ticketName':'成人票',
 'price':180,
 'num': 2
 }]
 
 */