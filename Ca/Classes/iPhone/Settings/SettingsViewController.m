//
//  SettingsViewController.m
//  ChatGPT
//
//  Created by Mali 357 on 17/08/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITextFieldDelegate>

@end
//tbh this is alright
@implementation SettingsViewController


//todo
//nothing
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *savedApiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    if (savedApiKey) {
        self.apiKeyInput.text = savedApiKey;
    }
    NSString *savedPrompt = [[NSUserDefaults standardUserDefaults] objectForKey:@"gptPrompt"];
    if (savedPrompt) {
        self.gptPromptInput.text = savedPrompt;
    }
    NSString *urlEndpoint = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiEndpoint"];
    if (urlEndpoint) {
        self.endpointSubmitInput.text = urlEndpoint;
    }
    NSString *AIModel = [[NSUserDefaults standardUserDefaults] objectForKey:@"AIModel"];
    if (AIModel) {
        self.AIModelInput.text = AIModel;
    }
    NSString *aiNickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"assistantNick"];
    if (aiNickName) {
        self.aiNickName.text = aiNickName;
    }
    NSString *userNickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNick"];
    if (userNickName) {
        self.userNickName.text = userNickName;
    }
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //yay
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSUserDefaults.standardUserDefaults setObject:self.apiKeyInput.text forKey:@"apiKey"];
    [NSUserDefaults.standardUserDefaults setObject:self.gptPromptInput.text forKey:@"gptPrompt"];
    [NSUserDefaults.standardUserDefaults setObject:self.userNickName.text forKey:@"userNick"];
    [NSUserDefaults.standardUserDefaults setObject:self.aiNickName.text forKey:@"assistantNick"];
    [NSUserDefaults.standardUserDefaults setObject:self.AIModelInput.text forKey:@"AIModel"];
    [NSUserDefaults.standardUserDefaults setObject:self.endpointSubmitInput.text forKey:@"apiEndpoint"];
}
@end

