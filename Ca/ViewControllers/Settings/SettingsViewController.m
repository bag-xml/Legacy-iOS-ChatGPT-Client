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
//this is prime example of me failing :pleading:
@implementation SettingsViewController


//todo
//apikey im retarded why didnt i include it
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

- (IBAction)submitPrompt:(id)sender {
    NSString *prompt = self.gptPromptInput.text;
    if (prompt.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:prompt forKey:@"gptPrompt"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (IBAction)submitApiKey:(id)sender {
    NSString *apiKey = self.apiKeyInput.text;
    if (apiKey.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:apiKey forKey:@"apiKey"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end

