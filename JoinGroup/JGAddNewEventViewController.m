//
//  JGAddNewEventViewController.m
//  JoinGroup
//
//  Created by user on 4/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGAddNewEventViewController.h"

@interface JGAddNewEventViewController ()

@end

@implementation JGAddNewEventViewController

@synthesize groupItems;
@synthesize eventTitle;
@synthesize eventDetails;
@synthesize pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.eventTitle || textField == self.eventDetails) {
        [textField resignFirstResponder];
    }
    return YES;
}
-(IBAction)creatEvent:(id)sender
{
    if ([self.eventTitle.text length] && self.groupItems) {
        NSDate *today = [NSDate date];
        NSDate *eventDate = [self.pickerView date];
        PFUser *user = [PFUser currentUser];
        PFGeoPoint *geoPoint = [self.groupItems objectForKey:@"Locations"];
        NSNumber *count = [[NSNumber alloc] initWithInt:1];
        PFObject *eventObject = [PFObject objectWithClassName:@"Event"];
        [eventObject setObject:[[NSNumber alloc] initWithInt:0] forKey:@"verifiedCount"];
        [eventObject setObject:self.eventTitle.text forKey:@"title"];
        [eventObject setObject:self.eventDetails.text forKey:@"details"];
        [eventObject setObject:today forKey:@"addedDate"];
        [eventObject setObject:eventDate forKey:@"eventDate"];
        [eventObject setObject:geoPoint forKey:@"locations"];
        [eventObject setObject:count forKey:@"memberCount"];
        [eventObject save];
        
        PFRelation *authorRelation = [eventObject relationforKey:@"author"];
        [authorRelation addObject:user];
        PFRelation *eventRelation = [eventObject relationforKey:@"attendants"];
        [eventRelation addObject:user];
        PFRelation *groupRelation = [eventObject relationforKey:@"inGroup"];
        [groupRelation addObject:self.groupItems];
        [eventObject save];
        PFRelation *relation = [self.groupItems relationforKey:@"hasEvents"];
        [relation addObject:eventObject];
        [self.groupItems save];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event created!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        PFRelation *inEventRelation = [user relationforKey:@"inEvent"];
        [inEventRelation addObject: eventObject];
        [user save];

    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.eventDetails setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
    [self.eventTitle setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
}

- (void)backgroundTouchedHideKeyboard:(id)sender
{
    [self.eventTitle resignFirstResponder];
    [self.eventDetails resignFirstResponder];
    [self viewWillAppear:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
