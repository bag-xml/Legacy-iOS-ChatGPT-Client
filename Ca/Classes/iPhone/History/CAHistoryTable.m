//
//  CAHistoryTable.m
//  ChatGPT
//
//  Created by bag.xml on 03/12/23.
//  Copyright (c) 2023 electron. All rights reserved.
//

#import "CAHistoryTable.h"

@interface CAHistoryTable ()

@property (nonatomic, strong) NSArray *conversationFiles;

@end

@implementation CAHistoryTable

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadConversationFiles];
}

//functions
- (void)loadConversationFiles {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *allFiles = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    
    self.conversationFiles = [allFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.txt'"]];
    [self.tableView reloadData];
}

- (void)impendingDoomOfDeletion {
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *allFiles = [fileManager contentsOfDirectoryAtPath:documentsDirectory error:nil];
    NSArray *txtFiles = [allFiles filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self ENDSWITH '.txt'"]];
    
    for (NSString *txtFile in txtFiles) {
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent:txtFile];
        [fileManager removeItemAtPath:filePath error:nil];
    }
    
    [self loadConversationFiles];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.conversationFiles count];
}

//eh
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"HistoryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSString *filename = [self.conversationFiles objectAtIndex:indexPath.row];
    cell.textLabel.text = filename;
    
    NSString *documentsDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    NSError *attributesError = nil;
    NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:&attributesError];
    
    if (!attributesError) {
        NSDate *creationDate = [fileAttributes objectForKey:NSFileCreationDate];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *formattedDate = [dateFormatter stringFromDate:creationDate];
        cell.detailTextLabel.text = formattedDate;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *selectedFilename = [self.conversationFiles objectAtIndex:indexPath.row];
    [self displayConversationFromFile:selectedFilename];
}

- (void)displayConversationFromFile:(NSString *)filename {
}


//Button actions
- (IBAction)deleteeverything:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Clear All Conversation?"
                                                        message:@"Are you sure you want to remove your previous conversations? Note that these cannot be restored, and if you wish to back them up, go to the application's local Documents directory and back them up."
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //i fr need keybag deleter some time
        [self impendingDoomOfDeletion];
    }
}

@end