//
//  SettingsViewController.m
//  ChatGPT
//
//  Created by Mali 357 on 17/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *gptPromptInput;
@property (weak, nonatomic) IBOutlet UITextField *apiKeyInput;

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
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //yay
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSUserDefaults.standardUserDefaults setObject:self.apiKeyInput.text forKey:@"apiKey"];
    [NSUserDefaults.standardUserDefaults setObject:self.gptPromptInput.text forKey:@"gptPrompt"];
}
@end

