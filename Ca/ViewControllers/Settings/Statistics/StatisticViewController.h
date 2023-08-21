//
//  StatisticViewController.h
//  ChatGPT
//
//  Created by Daphne on 21/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticViewController : UITableViewController
//top section, api related statistics
@property (strong, nonatomic) IBOutlet UITextField *apiRequestField;

//bottom section, unrelated from API information.
@property (strong, nonatomic) IBOutlet UITextField *versionOutput;

@end
