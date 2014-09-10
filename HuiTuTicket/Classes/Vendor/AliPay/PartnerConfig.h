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
#define PartnerPrivKey @"MIICXgIBAAKBgQDXDmE6RW+i+jaGo9SBntXza5BoSEGBPDafwILrf1e18Jm3ufrvnK8pKt+hMyEZ5xkQC9QdRL1Aw1ISkUxk/b8zXVUqn/0AFoY1OppKcYMOn23C4fgglTzuNrEK9cZD0chxl8HZ+uXglqu3tFjSZu68arUM4IRYzkhDyq0aJXvKPQIDAQABAoGBAI7eHLVrf5iUBTk5CWn7LUODR/IfXnUOnXNPnyn39TsHVfd6dDxOqQb+VoZuwyTEJCBG22l+SwQFPjbblBbbg/LRpJkYVWi6z903SCdR6UvZAegxRpeL3D59Oi+HX0XQFFMQtLDKW612C+jJIC8nQMnsMWssqPmeoybmH/hqq9eBAkEA9BZPrwoHFYEZNG811GenwvmG9ADfcFqWei8UvsoQwgE7ssaKMaHT2o8ias6ga0mHYq9gezHJq5HYnRZ2YoPkUQJBAOGNWQxbvB86PYJnKHPBfMqdpSxV3owB53HaKvvaGcgi6zaht2Vf/gBYkLHhE0gGnmfPWL9g5ImwYHgX+6agKC0CQQDuQTUIs+4URI64yvEtYvyzaeQcGxn/Tr1hiMFkNlNDO/bs27WbGs5zoZHD1etqrjwzzOKNfhzPly5sr7dhFELxAkAEtGUSG+u9nwJfcPVoDLYkp8slNJlSxEtmlY1l+XOmOAw99HuV0r3ClhZWj4JOc0zkj2+jdkruEE7C0oU+QYL1AkEAy/sRFIIQZeBU4OoyUqUboE62w10aGHXztWhR1XCfoS0fb4S3SkaFa1FuM7LWkMFqa5QSM660su8eGY40OlM1fw=="

//支付宝公钥
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCnxj/9qwVfgoUh/y2W89L6BkRAFljhNhgPdyPuBV64bfQNN1PjbCzkIM6qRdKBoLPXmKKMiFYnkd6rAoprih3/PrQEB/VsW8OoM8fxn67UDYuyBTqA23MML9q1+ilIZwBC2AQ2UBVOrFXfFl75p6/B5KsiNG9zpgmLCUYuLkxpLQIDAQAB"

#define PAY_NOTIFY_URL @"http://appapi.chemayi.com/service.php"


#endif
