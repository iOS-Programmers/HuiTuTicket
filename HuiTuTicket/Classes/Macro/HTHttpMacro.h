//
//  HTHttpMacro.h
//  HuiTuTicket
//
//  Created by Chemayi on 14-7-29.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#ifndef HuiTuTicket_HTHttpMacro_h
#define HuiTuTicket_HTHttpMacro_h

/**
 *  手机APP接口测试地址：
 1、会员接口API_URL: http://m-test.huitupiaowu.com/index.php/member
 2、景区门票接口API_URL: http://m-test.huitupiaowu.com/index.php/gateway
 3、我的联票接口API_URL: http://m-test.huitupiaowu.com/index.php/lp
 4、消息接口API_URL: http://m-test.huitupiaowu.com/index.php/msg
 5、其他接口API_URL: http://m-test.huitupiaowu.com/index.php/gateway
 
 联票注册预约系统接口测试地址：http://lp-test.huitupiaowu.com/api.php/rest
 
 测试 API_KEY = 123456
 
 以上接口地址，自2014年7月22日起可使用，如有问题，请及时联系。
 另：开发过程中，如遇到接口遗漏，或接口功能不能满足开发需要，请及时反馈。

 */


#define API_KEY    @"123456"
#define HOST_NAME  @"appapi.chemayi.com"

#define kURL_Member_Pre @"m-test.huitupiaowu.com/index.php/member"

#define kURL_MyTicket_Pre @"m-test.huitupiaowu.com/index.php/lp"

#define kURL_Message_Pre @"m-test.huitupiaowu.com/index.php/msg"

#define kURL_ScenicTicket_Pre @"m-test.huitupiaowu.com/index.php/gateway"

#define kURL_Ticket_Pre @"lp-test.huitupiaowu.com/api.php/rest"

#endif
