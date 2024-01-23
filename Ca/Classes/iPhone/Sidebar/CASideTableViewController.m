//
//  CASideTableViewController.m
//  ChatGPT
//
//  Created by bag.xml on 23/01/24.
//  Copyright (c) 2024 electron. All rights reserved.
//

#import "CASideTableViewController.h"
#import "APLSlideMenuViewController.h"
#import "ChatViewController.h"
#import "SettingsViewController.h"

@interface CASideTableViewController ()

@property (nonatomic, strong) NSIndexPath *currentIndexPath;

@end

@implementation CASideTableViewController

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
	
    self.currentIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView selectRowAtIndexPath:self.currentIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    if ([self respondsToSelector:@selector(topLayoutGuide)]) {
        self.tableView.contentInset = UIEdgeInsetsMake(20., 0., 0., 0.);
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView selectRowAtIndexPath:self.currentIndexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
    aCell.textLabel.text = [NSString stringWithFormat:@"Menu %ld",(long)indexPath.row];
    return aCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.currentIndexPath = indexPath;
    UINavigationController* navigationController = (UINavigationController*)self.slideMenuController.contentViewController;
    ChatViewController* contentViewController = navigationController.viewControllers.firstObject;
    if ([contentViewController isKindOfClass:[ChatViewController class]]) {
        [self.slideMenuController hideMenu:YES];
    }
}

@end
