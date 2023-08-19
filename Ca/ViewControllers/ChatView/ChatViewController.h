//
//  ChatViewController.h
//  Ca
//
//  Created by Mali 357 on 14/08/23.
//  Copyright (c) 2023 Mali357. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatViewController : UIViewController <NSURLConnectionDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (strong, nonatomic) IBOutlet UITableView *chatTableView;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;

@end
