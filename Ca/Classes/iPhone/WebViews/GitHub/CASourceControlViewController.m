//
//  CASourceControlViewController.m
//  ChatGPT
//
//  Created by bag.xml on 02/12/23.
//  Copyright (c) 2023 electron. All rights reserved.
//

#import "CASourceControlViewController.h"

@interface CASourceControlViewController ()

@end

@implementation CASourceControlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *newsletterURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"sourcecodepageendpoint"];
    
    NSURL *url = [NSURL URLWithString:newsletterURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.navigationItem.title = pageTitle;
}

@end
