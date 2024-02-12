//
//  SettingsViewController.m
//  ChatGPT
//
//  Created by Mali 357 on 17/08/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//

#import "SettingsViewController.h"
#import "APLSlideMenuViewController.h"

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
    /*
    NSString *aiNickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"assistantNick"];
    if (aiNickName) {
        self.aiNickName.text = aiNickName;
    }
    NSString *userNickName = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNick"];
    if (userNickName) {
        self.userNickName.text = userNickName;
    }
    */
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //yay
    return YES;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = [UIColor colorWithRed:116.0/255.0 green:116.0/255.0 blue:116.0/255.0 alpha:1.0];
    header.textLabel.shadowOffset = CGSizeMake(0, 0);
}

- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *footer = (UITableViewHeaderFooterView *)view;
    footer.textLabel.textColor = [UIColor colorWithRed:116.0/255.0 green:116.0/255.0 blue:116.0/255.0 alpha:1.0];
    footer.textLabel.shadowOffset = CGSizeMake(0, 0);
}

- (void)viewWillDisappear:(BOOL)animated {
    [NSUserDefaults.standardUserDefaults setObject:self.apiKeyInput.text forKey:@"apiKey"];
    [NSUserDefaults.standardUserDefaults setObject:self.gptPromptInput.text forKey:@"gptPrompt"];
    /*
    [NSUserDefaults.standardUserDefaults setObject:self.userNickName.text forKey:@"userNick"];
    [NSUserDefaults.standardUserDefaults setObject:self.aiNickName.text forKey:@"assistantNick"];
     */
    [NSUserDefaults.standardUserDefaults setObject:self.AIModelInput.text forKey:@"AIModel"];
    [NSUserDefaults.standardUserDefaults setObject:self.endpointSubmitInput.text forKey:@"apiEndpoint"];
}
@end

