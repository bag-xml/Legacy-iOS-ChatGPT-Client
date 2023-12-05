//
//  CAHistoryTextViewController.m
//  ChatGPT
//
//  Created by bag.xml on 03/12/23.
//  Copyright (c) 2023 electron. All rights reserved.
//

#import "CAHistoryTextViewController.h"

@interface CAHistoryTextViewController ()

@end

@implementation CAHistoryTextViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.textView.text = self.textToShow;
}
@end
