//
//  SubclassConfigViewController.h
//  LogInAndSignUpDemo
//
//  Created by Mattieu Gamache-Asselin on 6/15/12.
//  Copyright (c) 2012 Parse. All rights reserved.
//
#import <Parse/Parse.h>
#import "JGTabBarController.h"
#import "JGAddGroupViewController.h"
@interface SubclassConfigViewController : UIViewController <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) JGGroupViewController *groupViewController;

@end
