//
//  HTTicketRegisterController.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-24.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseViewController.h"

@interface HTTicketRegisterController : HTBaseViewController

//上级页面传过来的联票号码，如果有值，则在页面自动填上
@property (copy ,nonatomic) NSString *lpCodeNumer;

@end
