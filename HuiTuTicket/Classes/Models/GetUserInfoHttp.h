//
//  GetUserInfoHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "GetUserInfo.h"
#import "GetUserInfoPara.h"

/**
 *  获取会员信息接口
 */
@interface GetUserInfoHttp : LXHttpModel

@property (nonatomic, retain) GetUserInfoPara *parameter;
@property (nonatomic, retain) GetUserInfo *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
