//
//  JGForumViewController.h
//  JoinGroup
//
//  Created by user on 3/31/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JGForumTableViewController.h"
#import "JGForumViewController.h"
#import "JGForumAddPostViewController.h"

@interface JGForumViewController : UIViewController
@property (nonatomic, strong) JGForumTableViewController *forumTableViewController;
@property (strong, nonatomic) id eventItems;
@property (strong, nonatomic) id groupItems;
@property (weak, nonatomic) IBOutlet UILabel *countText;
- (IBAction)joinEvent:(id)sender;
- (IBAction)verifyAttendance:(id)sender;
@end
