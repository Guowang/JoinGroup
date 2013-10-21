//
//  JGEventsViewController.h
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "JGEventsTableViewController.h"
#import "JGAddNewEventViewController.h"
#import "JGForumViewController.h"
#import "CPFQueryCollectionViewController.h"

@interface JGEventsViewController : UIViewController
@property (nonatomic, strong) JGEventsTableViewController *eventsTableViewController;
@property (strong, nonatomic) id groupItems;
@property (weak, nonatomic) id groupViewController;
@property (weak, nonatomic) UIStoryboard *stb;
@end
