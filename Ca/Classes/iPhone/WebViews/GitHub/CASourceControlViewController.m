//
//  CASourceControlViewController.m
//  ChatGPT
//
//  Created by bag.xml on 02/12/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
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
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [self.webView loadRequest:request];
}

- (void)viewDidDisappear:(BOOL)animated {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    NSString *pageTitle = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    self.navigationItem.title = pageTitle;
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
