//
//  AlixPayResult.h
//  MSPInterface
//
//  Created by WenBi on 11-5-20.
//  Copyright 2011 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AlixPayResult : NSObject {
	int		  _statusCode;
	NSString *__weak _statusMessage;
	NSString *__weak _resultString;
	NSString *__weak _signString;
	NSString *__weak _signType;
}

@property(nonatomic, readonly) int statusCode;
@property(weak, nonatomic, readonly) NSString *statusMessage;
@property(weak, nonatomic, readonly) NSString *resultString;
@property(weak, nonatomic, readonly) NSString *signString;
@property(weak, nonatomic, readonly) NSString *signType;

- (id)initWithString:(NSString *)string;
@end
