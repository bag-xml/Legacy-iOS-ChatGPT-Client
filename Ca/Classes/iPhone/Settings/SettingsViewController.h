//
//  SettingsViewController.h
//  ChatGPT
//
//  Created by Mali 357 on 17/08/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *endpointSubmitInput;
@property (weak, nonatomic) IBOutlet UITextField *AIModelInput;
@property (weak, nonatomic) IBOutlet UITextField *aiNickName;
@property (weak, nonatomic) IBOutlet UITextField *userNickName;
@property (weak, nonatomic) IBOutlet UITextField *gptPromptInput;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyInput;

@end
