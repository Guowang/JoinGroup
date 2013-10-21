//
//  JGForumTableViewController.h
//  JoinGroup
//
//  Created by user on 4/2/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface JGForumTableViewController : PFQueryTableViewController
@property (strong, nonatomic) id eventItems;
@end
