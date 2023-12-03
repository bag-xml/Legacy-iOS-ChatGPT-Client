//
//  AdvancedOptionsViewController.m
//  ChatGPT
//
//  Created by bag.xml on 20/08/23.
//  Copyright (c) 2023 bag.xml. All rights reserved.
//


//this viewcontroller is literally an extension of settingsviewcontroller


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


- (void)viewWillDisappear:(BOOL)animated {
    [NSUserDefaults.standardUserDefaults setObject:self.userNickName.text forKey:@"userNick"];
    [NSUserDefaults.standardUserDefaults setObject:self.aiNickName.text forKey:@"assistantNick"];
    [NSUserDefaults.standardUserDefaults setObject:self.AIModelInput.text forKey:@"AIModel"];
    [NSUserDefaults.standardUserDefaults setObject:self.endpointSubmitInput.text forKey:@"apiEndpoint"];
}
@end
