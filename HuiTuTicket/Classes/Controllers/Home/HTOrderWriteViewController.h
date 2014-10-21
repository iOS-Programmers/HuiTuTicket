//
//  HTOrderWriteViewController.h
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseTableViewController.h"

@class ScenicDetail;

@interface HTOrderWriteViewController : HTBaseTableViewController
/**
 *  景区ID，上级界面传入
 */
@property (nonatomic, copy) NSString *scenicId;

/**
 *  景区详情对象 ，上级传入
 */
@property (nonatomic, strong) ScenicDetail *ticketDetail;

@end
