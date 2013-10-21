//
//  JGGroupTableViewController.h
//  JoinGroup
//
//  Created by user on 3/4/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <Parse/Parse.h>
#import <QuartzCore/QuartzCore.h>
#import "JGGroupDetailViewController.h"

@interface JGGroupTableViewController : PFQueryTableViewController
@property (weak, nonatomic) id groupViewController;
@property (weak, nonatomic) UIStoryboard *stb;
@property NSInteger index;
@end
