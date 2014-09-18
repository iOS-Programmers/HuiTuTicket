//
//  TPOrderCancelPara.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TPOrderCancelPara : LXParameterModel
@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *session_key;
@property (copy, nonatomic) NSString *orderid;
@property (copy, nonatomic) NSString *receive_moblie;
@property (copy, nonatomic) NSString *format;

@end
/*
 
 uid
 session_key
 orderid
 receive_moblie
 format
 
 */