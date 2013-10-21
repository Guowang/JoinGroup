//
//  JGMyGroupsViewController.m
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGMyGroupsViewController.h"

@interface JGMyGroupsViewController ()

@end

@implementation JGMyGroupsViewController
@synthesize eventViewButton;
- (IBAction)backFromEvents:(UIStoryboardSegue *)segue
{
    
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.myGroupsTableViewController = [[JGMyGroupsTableViewController alloc] init];
    [self.myGroupsTableViewController.tableView setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 500)];
    [self.view addSubview:self.myGroupsTableViewController.tableView];
    self.myGroupsTableViewController.stb = self.storyboard;
    self.myGroupsTableViewController.groupViewController = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
