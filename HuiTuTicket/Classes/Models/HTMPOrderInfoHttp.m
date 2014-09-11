//
//  HTMPOrderInfoHttp.m
//  HuiTuTicket
//
//  Created by Bird on 14-9-11.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTMPOrderInfoHttp.h"

@implementation HTMPOrderInfoHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[HTMPOrderInfoPara alloc] init];
        self.resultModel = [[HTMPOrderInfo alloc] init];
        //http://m-test.huitupiaowu.com/index.php/epay?method=ticket.pay.order.get&api_key=123456
        self.api_url = kURL_Ticket_Pay;
        self.apiFuncName = @"ticket.pay.order.get";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}


@end
