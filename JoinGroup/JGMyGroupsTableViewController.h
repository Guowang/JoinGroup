//
//  JGMyGroupsTableViewController.h
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "JGEventsViewController.h"

@interface JGMyGroupsTableViewController : PFQueryTableViewController
@property (weak, nonatomic) id groupViewController;
@property (weak, nonatomic) UIStoryboard *stb;
@end
