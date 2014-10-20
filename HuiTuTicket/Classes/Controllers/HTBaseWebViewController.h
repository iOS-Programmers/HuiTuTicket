//
//  HTBaseWebViewController.h
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseViewController.h"

@interface HTBaseWebViewController : HTBaseViewController<UIWebViewDelegate>

/**
 *  显示网页的控件
 */
@property (strong, nonatomic) UIWebView *webView;


/**
 *  需要加载的网址
 *
 *  @param urlString 网址
 */
- (void)loadDataWithURL:(NSString *)urlString;
@end
