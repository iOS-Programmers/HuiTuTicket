//
//  ResetPasswordHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "ResetPassword.h"
#import "ResetPasswordPara.h"

/**
 *  重设密码接口
 */
@interface ResetPasswordHttp : LXHttpModel


@property (nonatomic, retain) ResetPasswordPara *parameter;
@property (nonatomic, retain) ResetPassword *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
