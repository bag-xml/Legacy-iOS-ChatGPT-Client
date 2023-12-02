//
//  ChatViewController.m
//  ChatGPT - - - Project
//
//  Created by Mali 357 on 13/08/23.
//  Copyright (c) 2023 Mali357. All rights reserved.
//


//UITextView code is from https://github.com/ToruTheRedFox/iOS-Discord-Classic
//^^^^^^^pill shaped thing on toolbar for the not so smart people ^^^^^^^^^^^^
//not the actual content aka mainview

#import "ChatViewController.h"
#import "TRMalleableFrameView.h"

@interface ChatViewController () <UITextViewDelegate, NSURLConnectionDelegate>

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isKeyboardVisible;

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isKeyboardVisible = NO;
    
    self.inputField.delegate = self;
    
    self.responseData = [[NSMutableData alloc] init];
    
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.inputField setDelegate:self];
    self.inputFieldPlaceholder.text = [NSString stringWithFormat:@"Topic: %@", self.navigationItem.title];
    
    self.inputFieldPlaceholder.hidden = YES;
    
    [[self.insetShadow layer] setMasksToBounds:YES];
    [[self.insetShadow layer] setCornerRadius:16.0f];
    [[self.insetShadow layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.insetShadow layer] setBorderWidth:1.0f];
    [[self.insetShadow layer] setShadowColor:[UIColor blackColor].CGColor];
    [[self.insetShadow layer] setShadowOffset:CGSizeMake(0, 0)];
    [[self.insetShadow layer] setShadowOpacity:1];
    [[self.insetShadow layer] setShadowRadius:4.0];
}



// FUNCTIONS


//somewhere here is an issue. i dont know where but it crashes the app without me being able to debug it.
- (void)performRequest {
    NSString *gptprompt = [[NSUserDefaults standardUserDefaults] objectForKey:@"gptPrompt"];
    NSString *modelType = [[NSUserDefaults standardUserDefaults] objectForKey:@"AIModel"];
    NSString *message = self.inputField.text;
    NSString *apiEndpoint = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiEndpoint"];
    NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    NSString *userNickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNick"];
    NSString *userAgent = [[NSUserDefaults standardUserDefaults] objectForKey:@"User-Agent"];
    NSString *conversationHistory = [[NSUserDefaults standardUserDefaults] objectForKey:@"conversationHistory"];
    
    if (message.length > 0) {
        NSString *previousChat = self.chatTextView.text;
        if (previousChat.length > 0) {
            self.chatTextView.text = [NSString stringWithFormat:@"%@\n%@: %@", previousChat, userNickname, message];
        } else {
            self.chatTextView.text = [NSString stringWithFormat:@"%@: %@", userNickname, message];
        }
        
        self.inputField.text = @"";
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSURL *url = [NSURL URLWithString:apiEndpoint];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        NSLog(@"Request was sent. Endpoint specified is %@", apiEndpoint);
        [request setHTTPMethod:@"POST"];
        
        // HTTP Request headers
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"Bearer %@", apiKey] forHTTPHeaderField:@"Authorization"];
        // HELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELLELL HELL HELL
        NSMutableDictionary *bodyData = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                        @"model": [NSString stringWithFormat:@"%@", modelType],
                                                                                        @"messages": [NSMutableArray arrayWithArray:@[
                                                                                                                                      @{
                                                                                                                                          @"role": @"user",
                                                                                                                                          @"content": [gptprompt stringByAppendingString:message]
                                                                                                                                          }
                                                                                                                                      ]]
                                                                                        }];
        
        if (conversationHistory && ![conversationHistory isKindOfClass:[NSNull class]]) {
            [bodyData[@"messages"] addObject:@{
                                               @"role": @"assistant",
                                               @"content": conversationHistory
                                               }];
        }
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyData options:0 error:nil];
        [request setHTTPBody:jsonData];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
        NSLog(@"Connection started, as an overview, the specified model is %@, and the prompt is %@ as well as the Bearer Auth header being %@.", modelType, gptprompt, apiKey);
    }
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    
    NSArray *choices = [responseDictionary objectForKey:@"choices"];
    NSString *assistantNick = [[NSUserDefaults standardUserDefaults] objectForKey:@"assistantNick"];
    
    if ([choices count] > 0) {
        NSDictionary *choice = [choices objectAtIndex:0];
        NSDictionary *message = [choice objectForKey:@"message"];
        id contentObject = [message objectForKey:@"content"];
        [self brotherWhatAreYouDoing:contentObject];
        if (contentObject && ![contentObject isKindOfClass:[NSNull class]]) {
            NSString *assistantReply = [NSString stringWithFormat:@"%@", contentObject];
            NSString *updatedConversation = [NSString stringWithFormat:@"%@\n%@: %@", self.chatTextView.text, assistantNick, assistantReply];
            
            [[NSUserDefaults standardUserDefaults] setObject:updatedConversation forKey:@"conversationHistory"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            self.chatTextView.text = updatedConversation;
            NSRange bottomRange = NSMakeRange(self.chatTextView.text.length, 1);
            [self.chatTextView scrollRangeToVisible:bottomRange];
        }
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


- (void)brotherWhatAreYouDoing:(NSString *)message {
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    notification.alertBody = message;
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)keyboardWillShow:(NSNotification *)notification {
	
	//thx to Pierre Legrain
	//http://pyl.io/2015/08/17/animating-in-sync-with-ios-keyboard/
	
	int keyboardHeight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
	float keyboardAnimationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	int keyboardAnimationCurve = [[notification.userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey] integerValue];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:keyboardAnimationDuration];
	[UIView setAnimationCurve:keyboardAnimationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[self.chatTextView setHeight:self.view.height - keyboardHeight - self.toolbar.height];
	[self.toolbar setY:self.view.height - keyboardHeight - self.toolbar.height];
	[UIView commitAnimations];
	
	
	if(self.viewingPresentTime)
		[self.chatTextView setContentOffset:CGPointMake(0, self.chatTextView.contentSize.height - self.chatTextView.frame.size.height) animated:NO];
}


- (void)keyboardWillHide:(NSNotification *)notification {
	
	float keyboardAnimationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	int keyboardAnimationCurve = [[notification.userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey] integerValue];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:keyboardAnimationDuration];
	[UIView setAnimationCurve:keyboardAnimationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[self.chatTextView setHeight:self.view.height - self.toolbar.height];
	[self.toolbar setY:self.view.height - self.toolbar.height];
	[UIView commitAnimations];
}


//button actions

- (BOOL)textViewShouldReturn:(UITextView *)textView {
    [textView resignFirstResponder]; // make th keyboard go down when pressed return
    return YES;
}

//this sends the inputted contents of inputTextView (just check void(sendMessageTChatGPTAPI) to see what it exactly does.
- (IBAction)sendButtonTapped:(id)sender {
    [self performRequest];
    
    if(![self.inputField.text isEqual: @""]){
        
		[self.inputField setText:@""];
        self.inputFieldPlaceholder.hidden = NO;
	}else
		[self.inputField resignFirstResponder];
	
	if(self.viewingPresentTime)
		[self.chatTextView setContentOffset:CGPointMake(0, self.chatTextView.contentSize.height - self.chatTextView.frame.size.height) animated:YES];
}


//ok
- (IBAction)exportButtonTapped:(id)sender {
    NSString *textContent = self.chatTextView.text;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:@"conversation.txt"];
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    
    NSError *error = nil;
    [textContent writeToURL:fileURL atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    
    //open activityviewcontroller
    UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[fileURL] applicationActivities:nil];
    [self presentViewController:activityViewController animated:YES completion:nil];
}
//mail

-(IBAction)killYourSelf:(id)sender {
    
}


@end