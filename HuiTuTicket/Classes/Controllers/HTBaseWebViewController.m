//
//  HTBaseWebViewController.m
//  HuiTuTicket
//
//  Created by Chemayi on 14/8/18.
//  Copyright (c) 2014年 HuiTuTicket. All rights reserved.
//

#import "HTBaseWebViewController.h"

@interface HTBaseWebViewController ()



@end

@implementation HTBaseWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIWebView *)webView
{
    if (_webView) {
        
        CGRect webViewFrame = [[UIScreen mainScreen] applicationFrame];
        webViewFrame.origin.y = 0;
        webViewFrame.size.height -= CGRectGetHeight(self.navigationController.navigationBar.bounds);
                                    
        _webView = [[UIWebView alloc] initWithFrame:webViewFrame];
                                    
    }
                                    
    return _webView;
}

- (void)loadDataWithURL:(NSString *)urlString
{
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
