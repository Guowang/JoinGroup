//
//  JGEventsTableViewController.h
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "JGForumViewController.h"

@interface JGEventsTableViewController : PFQueryTableViewController
@property (strong, nonatomic) id groupItems;
@property (weak, nonatomic) id eventViewController;
@property (weak, nonatomic) UIStoryboard *stb;
@end
