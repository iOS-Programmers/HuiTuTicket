//
//  ScenicListHttp.h
//  HuiTuTicket
//
//  Created by Bird on 14-8-4.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "ScenicList.h"
#import "ScenicListPara.h"

/**
 *  景区门票列表接口
 */
@interface ScenicListHttp : LXHttpModel

@property (nonatomic, strong) ScenicListPara *parameter;
@property (nonatomic, strong) ScenicList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
