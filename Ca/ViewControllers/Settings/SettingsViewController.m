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

@end
//this is prime example of me failing :pleading:
@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

@end

