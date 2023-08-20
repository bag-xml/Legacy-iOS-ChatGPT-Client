//
//  ChatViewController.m
//  ChatGPT - - - Project
//
//  Created by Mali 357 on 13/08/23.
//  Copyright (c) 2023 Mali357. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTableViewCell.h"
@interface ChatViewController () <UITextFieldDelegate, NSURLConnectionDelegate>


@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, strong) NSMutableArray *chatMessages;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.inputTextField.delegate = self;
    
    self.chatMessages = [NSMutableArray array];
    self.responseData = [[NSMutableData alloc] init];
    
    [self.chatTableView registerClass:[ChatTableViewCell class] forCellReuseIdentifier:@"ChatCell"];
    
    self.chatTableView.delegate = self;
    self.chatTableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chatMessages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ChatTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChatCell" forIndexPath:indexPath];
    //aaaaaaaaaaaaaaaaaaaaaaaa
    NSString *message = self.chatMessages[indexPath.row];
    // split me: and message
    NSArray *messageComponents = [message componentsSeparatedByString:@": "];
    if (messageComponents.count == 2) {
        cell.usernameLabel.text = messageComponents[0];
        cell.contentsTextView.text = messageComponents[1];
    }
    
    return cell;
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    //[self sendMessageToChatGPTAPI];
    return YES;
}



- (void)sendMessageToChatGPTAPI {
    //strings
    NSString *gptprompt = [[NSUserDefaults standardUserDefaults] objectForKey:@"gptPrompt"];
    NSString *modelType = [[NSUserDefaults standardUserDefaults] objectForKey:@"AIModel"];
    NSString *message = self.inputTextField.text;
    NSString *apiEndpoint = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiEndpoint"];
    NSString *userNickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNick"];
    
    if (message.length > 0) {
        NSString *previousChat = [self.chatMessages componentsJoinedByString:@"\n"];
        NSString *newMessage = [NSString stringWithFormat:@"%@: %@", userNickname, message];
        NSString *updatedChat = previousChat.length > 0 ? [NSString stringWithFormat:@"%@\n%@", previousChat, newMessage] : newMessage;
        
        [self.chatMessages addObject:newMessage];
        [self.chatTableView reloadData];
        self.inputTextField.text = @"";
        
        
        
        // Actual request code
        NSURL *url = [NSURL URLWithString:apiEndpoint];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
        [request setValue:[NSString stringWithFormat:@"Bearer %@", apiKey] forHTTPHeaderField:@"Authorization"];
        
        NSDictionary *bodyData = @{
                                   //@"model": @"gpt-3.5-turbo",
                                   @"model": [NSString stringWithFormat:@"%@", modelType],
                                   @"messages": @[
                                           @{
                                               @"role": @"user",
                                               @"content": [gptprompt stringByAppendingString:message]
                                               }
                                           ]
                                   };
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyData options:0 error:nil];
        [request setHTTPBody:jsonData];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    }
}


//Connection related stuff

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    
    NSArray *choices = [responseDictionary objectForKey:@"choices"];
    if ([choices count] > 0) {
        NSDictionary *choice = [choices objectAtIndex:0];
        NSDictionary *message = [choice objectForKey:@"message"];
        NSString *assistantReply = [message objectForKey:@"content"];
        NSString *assistantNickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"assistantNick"];
        
        NSString *previousChat = [self.chatMessages componentsJoinedByString:@"\n"];
        NSString *newMessage = [NSString stringWithFormat:@"%@: %@", assistantNickname, assistantReply];
        //NSString *newMessage = [NSString stringWithFormat:@"ChatGPT: %@", assistantReply];
        NSString *updatedChat = previousChat.length > 0 ? [NSString stringWithFormat:@"%@\n%@", previousChat, newMessage] : newMessage;
        
        [self.chatMessages addObject:newMessage];
        [self.chatTableView reloadData];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.chatMessages.count - 1 inSection:0];
        [self.chatTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}


//button actions

- (IBAction)shotsWereFiredAtMyFriends:(id)sender {
    [self sendMessageToChatGPTAPI];
}

- (IBAction)saveButtonTapped:(id)sender {
    //todo: make this
    
}
// ttps://api.openai.com/v1/chat/completions
@end