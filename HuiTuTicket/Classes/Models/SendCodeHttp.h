//
//  SendCodeHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-5.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "SendCode.h"
#import "SendCodePara.h"

/**
 *  发送短信验证码接口
 */
@interface SendCodeHttp : LXHttpModel

@property (nonatomic, retain) SendCodePara *parameter;
@property (nonatomic, retain) SendCode *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
