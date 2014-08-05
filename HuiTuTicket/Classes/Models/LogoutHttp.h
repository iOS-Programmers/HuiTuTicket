//
//  LogoutHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "Logout.h"
#import "LogoutPara.h"

/**
 *  退出登录接口
 */
@interface LogoutHttp : LXHttpModel

@property (nonatomic, retain) LogoutPara *parameter;
@property (nonatomic, retain) Logout *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
