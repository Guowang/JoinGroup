//
//  JGGroupViewController.h
//  JoinGroup
//
//  Created by user on 2/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <FacebookSDK/FacebookSDK.h>
#import "UIImage+ResizeAdditions.h"
#import "JGGroupTableViewController.h"
#import "JGProfilePictureEditViewController.h"

@interface JGGroupViewController : UIViewController <NSURLConnectionDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) JGGroupTableViewController *groupTableViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *viewButton;
@property (nonatomic, strong) NSMutableData *imageData;
@property (nonatomic,strong) UINavigationController *navController;
- (IBAction)done:(UIStoryboardSegue *)segue;
- (IBAction)cancel:(UIStoryboardSegue *)segue;

@end
