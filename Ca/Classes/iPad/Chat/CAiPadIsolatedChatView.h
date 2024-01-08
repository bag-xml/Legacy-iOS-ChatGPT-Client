//
//  CAiPadIsolatedChatView.h
//  ChatGPT
//
//  Created by bag.xml on 01/12/23.
//  Copyright (c) 2023 bag.xml DOS Union. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CAiPadIsolatedChatView : UIViewController <NSURLConnectionDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet UITextView *inputField;
@property (weak, nonatomic) IBOutlet UILabel *inputFieldPlaceholder;
@property (weak, nonatomic) IBOutlet UIImageView *insetShadow;

@property bool viewingPresentTime;
@end
