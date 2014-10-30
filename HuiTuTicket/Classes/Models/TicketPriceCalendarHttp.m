//
//  TicketPriceCalendarHttp.m
//  HuiTuTicket
//
//  Created by Iceland on 14-8-7.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "TicketPriceCalendarHttp.h"

@implementation TicketPriceCalendarHttp
- (id)init
{
    self = [super init];
    if (nil != self){
        self.parameter = [[TicketPriceCalendarPara alloc] init];
        self.resultModel = [[TicketPriceCalendar alloc] init];
        //http://bizapp.cmyrelease.com/service.php?act=getWorkbench
        self.api_url = kURL_MyTicket_Pre;
        self.apiFuncName = @"scenic.ticket.pricecalendar";
    }
    return self;
}

- (void)getDataWithCompletionBlock:(HttpModelCompletionBlock)completionBlock
                       failedBlock:(HttpModelFailedBlock)failedBlock
{
    [self getDataWithParameters:self.parameter completionBlock:completionBlock failedBlock:failedBlock];
}

@end
