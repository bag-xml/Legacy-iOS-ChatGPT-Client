//
//  AdvancedOptionsViewController.m
//  ChatGPT
//
//  Created by Daphne on 20/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
//

#import "AdvancedOptionsViewController.h"

@interface AdvancedOptionsViewController ()

@end

@implementation AdvancedOptionsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *savedApiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    if (savedApiKey) {
        self.apiKeyInput.text = savedApiKey;
    }
    
    NSString *savedPrompt = [[NSUserDefaults standardUserDefaults] objectForKey:@"gptPrompt"];
    if (savedPrompt) {
        self.gptPromptInput.text = savedPrompt;
    }//reusing old code my beloved method
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
