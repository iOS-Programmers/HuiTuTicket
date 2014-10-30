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
 *  必传，设置从哪个订单页进来，默认是NO，默认显示从门票订单进来
 */
@property (nonatomic) BOOL isFromTaoPiao;

/**
 *  上级传入的，用来请求支付所需要的参数，notify_url
 */
@property (nonatomic, copy) NSString *orderId;

//出游日期
@property (nonatomic, copy) NSString *traveDate;
//产品名称
@property (nonatomic, copy) NSString *produtName;
//数量
@property (nonatomic, copy) NSString *number;
//价格
@property (nonatomic, copy) NSString *totalMoney;

@end
