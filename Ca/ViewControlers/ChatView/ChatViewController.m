//
//  ChatViewController.m
//  ChatGPT - - - Project
//
//  Created by Mali 357 on 13/08/23.
//  Copyright (c) 2023 Mali357. All rights reserved.
//

#import "ChatViewController.h"

@interface ChatViewController () <UITextViewDelegate, UITextFieldDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UITextView *chatTextView;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isKeyboardVisible;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.isKeyboardVisible = NO;
    
    //[self.view addSubview:self.chatTextView];
    
    self.inputTextField.delegate = self;
    
    self.responseData = [[NSMutableData alloc] init];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder]; // make th keyboard go down when pressed return
    //[self sendMessageToChatGPTAPI]; // button does that now.
    return YES;
}

- (void)sendMessageToChatGPTAPI {
    
    NSString *message = self.inputTextField.text;
    if (message.length > 0) {
        // Append the message to the chat text view
        NSString *previousChat = self.chatTextView.text;
        if (previousChat.length > 0) {
            self.chatTextView.text = [NSString stringWithFormat:@"%@\nMe: %@", previousChat, message];
        } else {
            self.chatTextView.text = [NSString stringWithFormat:@"Me: %@", message];
        }
        
        // clear the uitextfield aka make it so its empty
        self.inputTextField.text = @"";
        
        // make nsurlrequest to openai's api
        NSURL *url = [NSURL URLWithString:@"https://api.openai.com/v1/chat/completions"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        
        // i didnt know how this worked so i asked gpt
        NSString *apiKey = @"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"; //todo: make api key changeable in settings
        [request setValue:[NSString stringWithFormat:@"Bearer %@", apiKey] forHTTPHeaderField:@"Authorization"];
        
        // credits to some guy on stackoverflow for this
        NSDictionary *bodyData = @{
                                   @"model": @"gpt-3.5-turbo",
                                   @"messages": @[
                                           @{
                                               @"role": @"user",
                                               @"content": message
                                               }
                                           ]
                                   };        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyData options:0 error:nil];
        [request setHTTPBody:jsonData];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    }
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    NSLog(@"Connection error: %@", error);
}



- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // Parse the received response data from JSON
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    
    // Extract the assistants reply
    NSArray *choices = [responseDictionary objectForKey:@"choices"];
    if ([choices count] > 0) {
        NSDictionary *choice = [choices objectAtIndex:0];
        NSDictionary *message = [choice objectForKey:@"message"];
        NSString *assistantReply = [message objectForKey:@"content"];
        
        // give the replies a name (e.g. "ChatGPT:" n shit)
        NSString *previousChat = self.chatTextView.text;
        self.chatTextView.text = [NSString stringWithFormat:@"%@\nChatGPT: %@", previousChat, assistantReply];
        
        NSRange bottomRange = NSMakeRange(self.chatTextView.text.length, 1);
        [self.chatTextView scrollRangeToVisible:bottomRange];
    } else {
        //nothing
    }
}

//button actions (also uialertview)
- (IBAction)sendButtonTapped:(id)sender {
    [self sendMessageToChatGPTAPI];
}

- (IBAction)showAlertButtonPressed:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Unfortunate end."
                                                        message:@"This feature is nonexistent :o. You can't save yet (just copy this entire textview ig as a solution."
                                                       delegate:nil
                                              cancelButtonTitle:@":("
                                              otherButtonTitles:nil];
    
    [alertView show];
}


@end