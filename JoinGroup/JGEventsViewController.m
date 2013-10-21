//
//  JGEventsViewController.m
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGEventsViewController.h"
#import "JGEventCollectionViewCell.h"

@interface JGEventsViewController ()

@end

@implementation JGEventsViewController
@synthesize groupItems;
@synthesize groupViewController;
@synthesize stb;
@synthesize eventsTableViewController;

- (IBAction)backFromDiscussions:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)backFromAddNewEvent:(UIStoryboardSegue *)segue
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
    self.eventsTableViewController = [[JGEventsTableViewController alloc] init];
    self.eventsTableViewController.groupItems = self.groupItems;
    self.eventsTableViewController.stb = self.stb;
    self.eventsTableViewController.eventViewController = self;
    [self.eventsTableViewController.tableView setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 500.0f)];
    [self.view addSubview:self.eventsTableViewController.tableView];
 
 
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddNewEvents"]) {
        JGAddNewEventViewController *addNewEventViewController = [segue destinationViewController];
        addNewEventViewController.groupItems = self.groupItems;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
