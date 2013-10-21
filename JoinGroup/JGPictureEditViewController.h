//
//  JGPictureEditViewController.h
//  JoinGroup
//
//  Created by Meng Qi on 3/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "UIImage+ResizeAdditions.h"

@interface JGPictureEditViewController : UIViewController<UITextFieldDelegate, UIScrollViewDelegate>
@property NSString *groupIdForPhoto;
- (id)initWithImage:(UIImage *)aImage;

@end
