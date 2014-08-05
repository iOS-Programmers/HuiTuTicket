//
//  MessageListHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "MessageListPara.h"
#import "MessageList.h"

/**
 *  消息列表获取接口
 */
@interface MessageListHttp : LXHttpModel

@property (nonatomic, retain) MessageListPara *parameter;
@property (nonatomic, retain) MessageList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
