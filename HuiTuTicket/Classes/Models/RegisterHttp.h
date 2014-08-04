//
//  RegisterHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "Register.h"
#import "RegisterPara.h"

@interface RegisterHttp : LXHttpModel


@property (nonatomic, retain) RegisterPara *parameter;
@property (nonatomic, retain) Register *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
