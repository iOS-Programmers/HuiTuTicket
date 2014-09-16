//
//  TaoPiaoProductListHttp.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/9/16.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "LXHttpModel.h"
#import "TaoPiaoProductList.h"
#import "TaoPiaoProductListPara.h"

/**
 *  套票产品列表获取接口
 */
@interface TaoPiaoProductListHttp : LXHttpModel

@property (nonatomic, retain) TaoPiaoProductListPara *parameter;
@property (nonatomic, retain) TaoPiaoProductList *resultModel;

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock;

@end
