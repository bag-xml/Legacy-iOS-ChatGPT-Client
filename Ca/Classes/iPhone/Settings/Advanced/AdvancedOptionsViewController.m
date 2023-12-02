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
//reusing old code my beloved method
}
- (IBAction)confirmEndpoint:(id)sender {
    NSString *urlEndpoint = self.endpointSubmitInput.text;
    if (urlEndpoint.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:urlEndpoint forKey:@"apiEndpoint"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (IBAction)setAIModel:(id)sender {
    NSString *AIModel = self.AIModelInput.text;
    if (AIModel.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:AIModel forKey:@"AIModel"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (IBAction)submitAINickname:(id)sender {
    NSString *aiNickName = self.aiNickName.text;
    if (aiNickName.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:aiNickName forKey:@"assistantNick"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
- (IBAction)submituserNick:(id)sender {
    NSString *userNickName = self.userNickName.text;
    if (userNickName.length > 0) {
        [[NSUserDefaults standardUserDefaults] setObject:userNickName forKey:@"userNick"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end
