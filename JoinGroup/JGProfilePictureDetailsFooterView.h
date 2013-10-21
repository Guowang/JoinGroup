//
//  JGPhotoDetailsFooterView.h
//  JoinGroup
//
//  Created by Meng Qi on 3/15/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JGProfilePictureDetailsFooterView : UIView

@property (nonatomic, strong) UITextField *commentField;
@property (nonatomic) BOOL hideDropShadow;

+ (CGRect)rectForView;
@end
