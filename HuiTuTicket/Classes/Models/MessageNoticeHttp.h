//
//  MessageNoticeHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "MessageNotice.h"
#import "MessageNoticePara.h"

/**
 *  新消息通知接口
 */
@interface MessageNoticeHttp : LXHttpModel

@property (nonatomic, retain) MessageNoticePara *parameter;
@property (nonatomic, retain) MessageNotice *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
