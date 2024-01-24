//
//  CANewsletterViewController.m
//  ChatGPT
//
//  Created by bag.xml on 02/12/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//

#import "CANewsletterViewController.h"

@interface CANewsletterViewController () <UIWebViewDelegate>

@end

@implementation CANewsletterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *newsletterURL = [[NSUserDefaults standardUserDefaults] objectForKey:@"mali357gptendpoint"];
    
    NSURL *url = [NSURL URLWithString:newsletterURL];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    self.navigationItem.title = pageTitle;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
