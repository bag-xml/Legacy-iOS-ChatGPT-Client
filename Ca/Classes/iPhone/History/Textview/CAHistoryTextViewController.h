//
//  CAHistoryTextViewController.h
//  ChatGPT
//
//  Created by bag.xml on 03/12/23.
//  Copyright (c) 2023 electron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAHistoryTextViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, strong) NSString *textToShow;

@end
