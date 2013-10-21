//
//  JGMyGroupsViewController.h
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JGMyGroupsTableViewController.h"

@interface JGMyGroupsViewController : UIViewController
@property (nonatomic, strong) JGMyGroupsTableViewController *myGroupsTableViewController;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *eventViewButton;
@end

