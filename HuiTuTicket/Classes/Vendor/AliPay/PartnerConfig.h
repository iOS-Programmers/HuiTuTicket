//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h

//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088412974299645"
//收款支付宝账号
#define SellerID  @"2088412974299645"

//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY @"hku47d2sj79h1yn9wup52ntimu3n4xjx"

//商户私钥，自助生成
#define PartnerPrivKey @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBANcOYTpFb6L6Noaj1IGe1fNrkGhIQYE8Np/Agut/V7Xwmbe5+u+crykq36EzIRnnGRAL1B1EvUDDUhKRTGT9vzNdVSqf/QAWhjU6mkpxgw6fbcLh+CCVPO42sQr1xkPRyHGXwdn65eCWq7e0WNJm7rxqtQzghFjOSEPKrRole8o9AgMBAAECgYEAjt4ctWt/mJQFOTkJafstQ4NH8h9edQ6dc0+fKff1OwdV93p0PE6pBv5Whm7DJMQkIEbbaX5LBAU+NtuUFtuD8tGkmRhVaLrP3TdIJ1HpS9kB6DFGl4vcPn06L4dfRdAUUxC0sMpbrXYL6MkgLydAyewxayyo+Z6jJuYf+Gqr14ECQQD0Fk+vCgcVgRk0bzXUZ6fC+Yb0AN9wWpZ6LxS+yhDCATuyxooxodPajyJqzqBrSYdir2B7McmrkdidFnZig+RRAkEA4Y1ZDFu8Hzo9gmcoc8F8yp2lLFXejAHncdoq+9oZyCLrNqG3ZV/+AFiQseETSAaeZ89Yv2DkibBgeBf7pqAoLQJBAO5BNQiz7hREjrjK8S1i/LNp5BwbGf9OvWGIwWQ2U0M79uzbtZsaznOhkcPV62quPDPM4o1+HM+XLmyvt2EUQvECQAS0ZRIb672fAl9w9WgMtiSnyyU0mVLES2aVjWX5c6Y4DD30e5XSvcKWFlaPgk5zTOSPb6N2Su4QTsLShT5BgvUCQQDL+xEUghBl4FTg6jJSpRugTrbDXRoYdfO1aFHVcJ+hLR9vhLdKRoVrUW4zstaQwWprlBIzrrSy7x4ZjjQ6UzV/"

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#define PAY_NOTIFY_URL @"http://appapi.chemayi.com/service.php"


#endif
