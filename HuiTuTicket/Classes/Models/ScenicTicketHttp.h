//
//  ScenicTicketHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "ScenicTicket.h"
#import "ScenicTicketPara.h"

@interface ScenicTicketHttp : LXHttpModel

@property (nonatomic, strong) ScenicTicketPara *parameter;
@property (nonatomic, strong) ScenicTicket *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;


@end
