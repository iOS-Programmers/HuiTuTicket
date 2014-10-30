//
//  HomeBannerHttp.h
//  HuiTuTicket
//
//  Created by Bird on 14-8-22.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "HomeBanner.h"
#import "HomeBannerPara.h"

@interface HomeBannerHttp : LXHttpModel
@property (nonatomic, strong) HomeBannerPara *parameter;
@property (nonatomic, strong) HomeBanner *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;
@end
