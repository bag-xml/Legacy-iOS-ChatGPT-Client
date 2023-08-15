//
//  ChatViewController.m
//  ChatGPT - - - Project
//
//  Created by Mali 357 on 13/08/23.
//  Copyright (c) 2023 Mali357. All rights reserved.
//

#import "iPadChatViewController.h"

@interface iPadChatViewController () <UITextViewDelegate, UITextFieldDelegate, NSURLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UITextView *chatTextView;
@property (strong, nonatomic) IBOutlet UITextField *inputTextField;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isKeyboardVisible;

@end

@implementation iPadChatViewController

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

//button actions

//this sends the inputted contents of inputTextView (just check void(sendMessageTChatGPTAPI) to see what it exactly does.
- (IBAction)sendButtonTapped:(id)sender {
    [self sendMessageToChatGPTAPI];
}


//this was hard asf wtf i needed like 1+ day for this hsit
- (IBAction)exportButtonTapped:(id)sender {
    NSString *textContent = self.chatTextView.text;
    
    //hard asf
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"conversation.txt"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    // again: thanks stackoverflow
    NSError *error = nil;
    [textContent writeToURL:fileURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    
    //open activityviewcontroller
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[fileURL] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}
//todo: confirm if mail even works, also try to get more shit in there except "mail".


@end