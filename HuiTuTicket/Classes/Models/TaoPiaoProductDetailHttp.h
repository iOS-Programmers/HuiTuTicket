//
//  TaoPiaoProductDetailHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/17.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TaoPiaoProductDetail.h"
#import "TaoPiaoProductDetailPara.h"

@interface TaoPiaoProductDetailHttp : LXHttpModel

@property (nonatomic, retain) TaoPiaoProductDetailPara *parameter;
@property (nonatomic, retain) TaoPiaoProductDetail *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
