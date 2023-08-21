//
//  StatisticViewController.m
//  ChatGPT
//
//  Created by Daphne on 21/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
//

#import "StatisticViewController.h"

@interface StatisticViewController ()

@end

@implementation StatisticViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //app version stored in nsuserdefaults (yes bad solution ik)
    NSString *appVersion = [[NSUserDefaults standardUserDefaults] objectForKey:@"version"];
    if (appVersion) {
        self.versionOutput.text = appVersion;
    }
    
}


@end
