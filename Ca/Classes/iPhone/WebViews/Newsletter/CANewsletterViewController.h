//
//  CANewsletterViewController.h
//  ChatGPT
//
//  Created by bag.xml on 02/12/23.
//  Copyright (c) 2023 electron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CANewsletterViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
