//
//  JGAppDelegate.h
//  JoinGroup
//
//  Created by user on 2/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "JGTabBarController.h"
#import "SubclassConfigViewController.h"

extern NSString *const FBSessionStateChangedNotification;

@interface JGAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end
