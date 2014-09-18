//
//  TPOrderListPara.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TPOrderListPara : LXParameterModel

@property (strong, nonatomic) NSString *uid;
@property (strong, nonatomic) NSString *session_key;
@property (strong, nonatomic) NSString *order_state;
@property (strong, nonatomic) NSString *page;
@property (strong, nonatomic) NSString *pagesize;
@property (strong, nonatomic) NSString *format;

@end


/*
 
 uid
 session_key
 order_state
 page
 pagesize
 format
 
 */