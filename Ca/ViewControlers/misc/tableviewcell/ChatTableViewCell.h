//
//  ChatTableViewCell.h
//  ChatGPT
//
//  Created by Mali 357 on 19/08/23.
//  Copyright (c) 2023 Daphne. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *userIconImageView;
//image position still questionable for now. thats why i left it out in (void)layoutSubviews

@property (nonatomic, strong) UILabel *usernameLabel;
@property (nonatomic, strong) UITextView *contentsTextView;

@end