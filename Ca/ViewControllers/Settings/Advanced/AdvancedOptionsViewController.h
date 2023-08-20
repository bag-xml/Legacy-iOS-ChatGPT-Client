//
//  AdvancedOptionsViewController.h
//  ChatGPT
//
//  Created by Daphne on 20/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdvancedOptionsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *endpointSubmitInput;
@property (weak, nonatomic) IBOutlet UITextField *AIModelInput;
@end
