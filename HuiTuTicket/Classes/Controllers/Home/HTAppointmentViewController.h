//
//  HTAppointmentViewController.h
//  HuiTuTicket
//
//  Created by viewalloc on 14-8-3.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseTableViewController.h"

@interface HTAppointmentViewController : HTBaseTableViewController


/**
 *  联票序列号，上级传入
 */
@property (copy, nonatomic) NSString *codeNumber;

/**
 *  姓名，上级传入
 */
@property (copy, nonatomic) NSString *userName;
@end
