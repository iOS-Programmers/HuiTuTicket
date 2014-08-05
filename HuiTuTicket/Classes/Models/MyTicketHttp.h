//
//  MyTicketHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "MyTicket.h"
#import "MyTicketPara.h"
/**
 *  我的联票接口
 */
@interface MyTicketHttp : LXHttpModel

@property (nonatomic, retain) MyTicketPara *parameter;
@property (nonatomic, retain) MyTicket *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
