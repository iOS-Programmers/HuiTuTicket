//
//  MyTicketDetailInfoHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/20.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "MyTicketDetailInfoPara.h"
#import "MyTicketDetailInfo.h"

/**
 *  联票注册信息获取接口
 */
@interface MyTicketDetailInfoHttp : LXHttpModel

@property (nonatomic, retain) MyTicketDetailInfoPara *parameter;
@property (nonatomic, retain) MyTicketDetailInfo *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
