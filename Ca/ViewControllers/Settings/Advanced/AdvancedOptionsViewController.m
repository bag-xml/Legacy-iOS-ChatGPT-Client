//
//  AdvancedOptionsViewController.m
//  ChatGPT
//
//  Created by Daphne on 20/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
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
        [[NSUserDefaults standardUserDefaults] setObject:AIModel forKey:@"apiEndpoint"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

@end