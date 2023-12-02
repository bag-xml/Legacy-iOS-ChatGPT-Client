//
//  AdvancedOptionsViewController.h
//  ChatGPT
//
//  Created by bag.xml on 20/08/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedOptionsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *endpointSubmitInput;
@property (weak, nonatomic) IBOutlet UITextField *AIModelInput;
@property (weak, nonatomic) IBOutlet UITextField *aiNickName;
@property (weak, nonatomic) IBOutlet UITextField *userNickName;
@end
