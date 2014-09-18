//
//  TPOrderSubmitPara.h
//  HuiTuTicket
//
//  Created by Iceland on 14-9-19.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXParameterModel.h"

@interface TPOrderSubmitPara : LXParameterModel

@property (copy, nonatomic) NSString *uid;
@property (copy, nonatomic) NSString *session_key;
@property (copy, nonatomic) NSString *tpid;
@property (copy, nonatomic) NSString *number;
@property (copy, nonatomic) NSString *travel_time;
@property (copy, nonatomic) NSString *receive_name;
@property (copy, nonatomic) NSString *receive_moblie;
@property (copy, nonatomic) NSString *app_ver;
@property (copy, nonatomic) NSString *sig;
@property (copy, nonatomic) NSString *format;

@end

/*
 
 uid
 session_key
 tpid
 number
 travel_time
 receive_name
 receive_moblie
 app_ver
 sig
 format
 
 
 */
