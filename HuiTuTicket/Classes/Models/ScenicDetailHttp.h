//
//  ScenicDetailHttp.h
//  HuiTuTicket
//
//  Created by Iceland on 14-8-6.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "ScenicDetail.h"
#import "ScenicDetailPara.h"

/**
 *  景区详细信息接口
 */
@interface ScenicDetailHttp : LXHttpModel

@property (nonatomic, strong) ScenicDetailPara *parameter;
@property (nonatomic, strong) ScenicDetail *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
