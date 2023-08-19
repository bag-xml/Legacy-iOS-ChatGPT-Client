//
//  SettingsViewController.m
//  ChatGPT
//
//  Created by Mali 357 on 17/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController () <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *inputText;
@property (strong, nonatomic) IBOutlet UITextField *degenprompt;

@end
//this is prime example of me failing :pleading:
@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *savedText = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    if (savedText) {
        self.inputText.text = savedText;
    }
    
    self.inputText.delegate = self;
}


- (IBAction)submit:(id)sender {
    //ok button code here, glad that it worked, it was just the splitview of xcode being fucked
}





#pragma mark - UITextFieldDelegate

//this is the API Key box.
//chatgpt my beloved
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:
    //nsstring
    (NSString *)string {
    NSString *currentText = textField.text;
    NSString *newText = [currentText stringByReplacingCharactersInRange:range withString:string];
    
    // save new text to pref
    if (newText.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:newText forKey:@"apiKey"];
    }
//udpdaze api eyk
    NSString *configPath = [[NSBundle mainBundle] pathForResource:@"info" ofType:@"plist"];
    
    NSMutableDictionary *configDict = [NSMutableDictionary dictionaryWithContentsOfFile:configPath];
    configDict[@"apiKey"] = newText;
    
    [configDict writeToFile:configPath atomically:YES];

    return YES;
}

@end

