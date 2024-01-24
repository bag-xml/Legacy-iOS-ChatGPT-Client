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
#import "UIBubbleTableView.h"
#import "NSBubbleData.h"
#import "TRMalleableFrameView.h"
#import "APLSlideMenuViewController.h"

@interface ChatViewController () <UIBubbleTableViewDelegate, UIBubbleTableViewDataSource, NSURLConnectionDelegate>

@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
    CGFloat iOSVersion = [systemVersion floatValue];
    
    self.slideMenuController.bouncing = YES;
    self.slideMenuController.gestureSupport = APLSlideMenuGestureSupportDrag;
    self.slideMenuController.separatorColor = [UIColor grayColor];
    
    self.chatTableView.showAvatars = YES;
    self.chatTableView.watchingInRealTime = YES;
    self.chatTableView.snapInterval = 2800;
    self.chatTableView.bubbleDataSource = self;
    self.bubbleDataArray = [NSMutableArray array];
    [self.chatTableView reloadData];
    
    self.isKeyboardVisible = NO;
    
    self.inputField.delegate = self;
    
    self.responseData = [[NSMutableData alloc] init];
    
    
    //the bottom
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	
	[NSNotificationCenter.defaultCenter addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.inputField setDelegate:self];
    self.inputFieldPlaceholder.hidden = YES;
    [[self.insetShadow layer] setMasksToBounds:YES];
    [[self.insetShadow layer] setCornerRadius:16.0f];
    [[self.insetShadow layer] setBorderColor:[UIColor whiteColor].CGColor];
    [[self.insetShadow layer] setBorderWidth:1.0f];
    [[self.insetShadow layer] setShadowColor:[UIColor blackColor].CGColor];
    [[self.insetShadow layer] setShadowOffset:CGSizeMake(0, 0)];
    [[self.insetShadow layer] setShadowOpacity:1];
    [[self.insetShadow layer] setShadowRadius:4.0];
    
    //dishery

    if (iOSVersion < 6.0) {
        NSString *errorMessage = @"Just a quick warning by me, this app may show unintended behaviors on iOS 5.x.x. If you wish to disregard this, just press 'Okay' and go on with your day.";
        [self showAlertWithTitle:@"Woah there buddy" message:errorMessage];
    } else if(iOSVersion > 7.0) {
        self.chatTableView.backgroundColor = [UIColor whiteColor];
    }

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}


- (void)performRequest {
    NSString *gptprompt = [[NSUserDefaults standardUserDefaults] objectForKey:@"gptPrompt"];
    NSString *modelType = [[NSUserDefaults standardUserDefaults] objectForKey:@"AIModel"];
    NSString *message = self.inputField.text;
    NSString *apiEndpoint = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiEndpoint"];
    NSString *apiKey = [[NSUserDefaults standardUserDefaults] objectForKey:@"apiKey"];
    NSString *userNickname = [[NSUserDefaults standardUserDefaults] objectForKey:@"userNick"];
    NSString *conversationHistory = [[NSUserDefaults standardUserDefaults] objectForKey:@"conversationHistory"];
    
    if (apiKey.length == 0) {
        NSString *errorMessage = @"You have no API key set, please go to the settings page to set one, or refer to the guide on how to create a valid one + set it";
        [self showAlertWithTitle:@"API Key Error" message:errorMessage];
        return;
    }
    
    if (message.length > 0) {
        self.inputField.text = @"";
        
        
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        NSURL *url = [NSURL URLWithString:apiEndpoint];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        // HTTP Request headers
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:[NSString stringWithFormat:@"Bearer %@", apiKey] forHTTPHeaderField:@"Authorization"];
        
        NSMutableArray *messagesArray = [NSMutableArray arrayWithArray:@[
                                                                         @{
                                                                             @"role": @"user",
                                                                             @"content": [gptprompt stringByAppendingString:message]
                                                                             }
                                                                         ]];
        
        if (conversationHistory && ![conversationHistory isKindOfClass:[NSNull class]]) {
            [messagesArray addObject:@{
                                       @"role": @"assistant",
                                       @"content": conversationHistory
                                       }];
        }
        
        NSMutableDictionary *bodyData = [NSMutableDictionary dictionaryWithDictionary:@{
                                                                                        @"model": [NSString stringWithFormat:@"%@", modelType],
                                                                                        @"messages": messagesArray
                                                                                        }];
        
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:bodyData options:0 error:nil];
        [request setHTTPBody:jsonData];
        
        NSBubbleData *userBubbleData = [NSBubbleData dataWithText:[gptprompt stringByAppendingString:message] date:[NSDate date] type:BubbleTypeMine];
        
        [self.bubbleDataArray addObject:userBubbleData];
        [self.chatTableView reloadData];
        
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:self.responseData options:0 error:nil];
    NSLog(@"Response received");
    
    NSDictionary *errorInfo = [responseDictionary objectForKey:@"error"];
    if (errorInfo) {
        NSString *errorMessage = [errorInfo objectForKey:@"message"];
        [self showAlertWithTitle:@"Error" message:errorMessage];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        return;
    }

    NSArray *choices = [responseDictionary objectForKey:@"choices"];
    NSString *assistantNick = [[NSUserDefaults standardUserDefaults] objectForKey:@"assistantNick"];
    
    if ([choices count] > 0) {
        NSDictionary *choice = [choices objectAtIndex:0];
        NSDictionary *message = [choice objectForKey:@"message"];
        id contentObject = [message objectForKey:@"content"];
        
        if (contentObject && ![contentObject isKindOfClass:[NSNull class]]) {
            NSString *assistantReply = [NSString stringWithFormat:@"%@", contentObject];
            NSString *previousConversationHistory = [[NSUserDefaults standardUserDefaults] objectForKey:@"conversationHistory"];
            if (![assistantReply isEqualToString:previousConversationHistory]) {
                NSBubbleData *assistantBubbleData = [NSBubbleData dataWithText:assistantReply date:[NSDate date] type:BubbleTypeSomeoneElse];
                assistantBubbleData.avatar = [UIImage imageNamed:@"assistant.png"];
                [self.bubbleDataArray addObject:assistantBubbleData];
                
                [[NSUserDefaults standardUserDefaults] setObject:assistantReply forKey:@"conversationHistory"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                
                [self.chatTableView reloadData];
                
                [self.chatTableView scrollBubbleViewToBottomAnimated:YES];
            }
        }
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    self.responseData.length = 0;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
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
	[self.chatTableView setHeight:self.view.height - keyboardHeight - self.toolbar.height];
	[self.toolbar setY:self.view.height - keyboardHeight - self.toolbar.height];
	[UIView commitAnimations];
	
	
	if(self.viewingPresentTime)
		[self.chatTableView setContentOffset:CGPointMake(0, self.chatTableView.contentSize.height - self.chatTableView.frame.size.height) animated:NO];
}


- (void)keyboardWillHide:(NSNotification *)notification {
	
	float keyboardAnimationDuration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
	int keyboardAnimationCurve = [[notification.userInfo objectForKey: UIKeyboardAnimationCurveUserInfoKey] integerValue];
	
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:keyboardAnimationDuration];
	[UIView setAnimationCurve:keyboardAnimationCurve];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[self.chatTableView setHeight:self.view.height - self.toolbar.height];
	[self.toolbar setY:self.view.height - self.toolbar.height];
	[UIView commitAnimations];
}


//BUBBLE TABLE VIEW

#pragma mark uibubbletableview data source

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView {
    return [self.bubbleDataArray count];
}

- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row {
    return [self.bubbleDataArray objectAtIndex:row];
}
//end of bubbles :(

//misc
- (BOOL)textViewShouldReturn:(UITextView *)chatTableView {
    [chatTableView resignFirstResponder]; // make th keyboard go down when pressed return
    return YES;
}

//and... off it goes!
- (IBAction)sendButtonTapped:(id)sender {
            [self.inputField resignFirstResponder];
    [self performRequest];
    
    if(![self.inputField.text isEqual: @""]){
        
		[self.inputField setText:@""];
        self.inputFieldPlaceholder.hidden = NO;
	} else
	
	if(self.viewingPresentTime)
		[self.chatTableView setContentOffset:CGPointMake(0, self.chatTableView.contentSize.height - self.chatTableView.frame.size.height) animated:YES];
}


//this is for actionsheets and alerts
- (IBAction)exportButtonTapped:(id)sender {
    UIActionSheet *messageActionSheet = [[UIActionSheet alloc] initWithTitle:@"What do you want to do" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:@"Clear conversation" otherButtonTitles:nil];
    [messageActionSheet setTag:1];
    [messageActionSheet setDelegate:self];
    [messageActionSheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == 1) {
        if (buttonIndex == actionSheet.destructiveButtonIndex) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Clear Conversation" message:@"Are you sure you want to clear the entire conversation?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Clear", nil];
            [alertView show];
        }
    }
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == alertView.firstOtherButtonIndex) {
        [self removeEverything];
    }
}

- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alertView show];
}

- (void)removeEverything {
    [self.bubbleDataArray removeAllObjects];
    [self.chatTableView reloadData];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"conversationHistory"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.chatTableView scrollBubbleViewToBottomAnimated:YES];
}
//actionsheet + alert end



- (IBAction)glorious:(id)sender {
    [self.slideMenuController showLeftMenu:YES];
}

@end