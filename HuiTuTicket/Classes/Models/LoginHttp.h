//
//  LoginHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "Login.h"
#import "LoginPara.h"

@interface LoginHttp : LXHttpModel


@property (nonatomic, retain) LoginPara *parameter;
@property (nonatomic, retain) Login *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
