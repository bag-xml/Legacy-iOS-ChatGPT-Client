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
#import <QuartzCore/QuartzCore.h>

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
    UIImage *backgroundImage = [UIImage imageNamed:@"sidebarbg"];
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithImage:backgroundImage];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill; // Adjust the content mode based on your preference
    self.tableView.backgroundView = backgroundImageView;
    
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

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *aCell = [tableView dequeueReusableCellWithIdentifier:@"aCell"];
    aCell.textLabel.text = [NSString stringWithFormat:@"Chat"];
    return aCell;
}*/
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *cellIdentifier = selectedCell.reuseIdentifier;
    
    if ([cellIdentifier isEqualToString:@"aCell"]) {
        self.currentIndexPath = indexPath;
        UINavigationController *navigationController = (UINavigationController *)self.slideMenuController.contentViewController;
        ChatViewController *contentViewController = navigationController.viewControllers.firstObject;
        
        if ([contentViewController isKindOfClass:[ChatViewController class]]) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [self.slideMenuController hideMenu:YES];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"aCell";
    static NSString *cell2 = @"bCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sidebarcell"]];
    [bg setFrame:CGRectMake(0, 0, 161.5, 42.5)];
    // Configure the cell...
    cell.backgroundView = bg;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28.0f;
}

@end
