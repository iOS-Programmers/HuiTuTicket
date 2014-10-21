//
//  HTOrderResultViewController.h
//  HuiTuTicket
//
//  Created by 李 广军 on 14-8-8.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseViewController.h"

@interface HTOrderResultViewController : HTBaseViewController


/**
 *  上级传入的，用来请求支付所需要的参数，notify_url
 */
@property (nonatomic, copy) NSString *orderId;
@end
