//
//  CAPrefTable.h
//  ChatGPT
//
//  Created by bag.xml on 09/12/23.
//  Copyright (c) 2023 electron. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAPrefTable : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *gptPromptInput;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyInput;
@property (weak, nonatomic) IBOutlet UITextField *endpointSubmitInput;
@property (weak, nonatomic) IBOutlet UITextField *AIModelInput;
@property (weak, nonatomic) IBOutlet UITextField *aiNickName;
@property (weak, nonatomic) IBOutlet UITextField *userNickName;

@end
