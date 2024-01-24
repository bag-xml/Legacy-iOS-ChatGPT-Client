//
//  ChatViewController.h
//  Ca
//
//  Created by Mali 357 on 14/08/23.
//  Copyright (c) 2023 Mali357. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIBubbleTableView.h"

@interface ChatViewController : UIViewController <NSURLConnectionDelegate, UINavigationControllerDelegate, UIBubbleTableViewDataSource, UIBubbleTableViewDelegate, UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;
@property (weak, nonatomic) IBOutlet UITextView *inputField;
@property (weak, nonatomic) IBOutlet UIBubbleTableView *chatTableView;
@property (weak, nonatomic) IBOutlet UILabel *inputFieldPlaceholder;
@property (weak, nonatomic) IBOutlet UIImageView *insetShadow;

@property (nonatomic, strong) NSMutableData *responseData;
@property (nonatomic, assign) BOOL isKeyboardVisible;
@property (nonatomic, strong) NSMutableArray *bubbleDataArray;

@property UIRefreshControl *refreshControl;

@property bool viewingPresentTime;
@end
