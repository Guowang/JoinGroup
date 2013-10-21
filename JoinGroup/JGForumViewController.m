//
//  JGForumViewController.m
//  JoinGroup
//
//  Created by user on 3/31/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGForumViewController.h"
#import "JGLocationController.h"

@interface JGForumViewController ()

@end

@implementation JGForumViewController
@synthesize forumTableViewController;
@synthesize eventItems;
@synthesize groupItems;
@synthesize countText;
- (IBAction)backFromAddNewPosts:(UIStoryboardSegue *)segue
{
    
}

-(IBAction)joinEvent:(id)sender
{
    if (self.eventItems) {
        PFUser *user = [PFUser currentUser];
        PFRelation *eventRelation = [self.eventItems relationforKey:@"attendants"];
        [eventRelation addObject:user];
        [self.eventItems save];
        PFQuery *query = [eventRelation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            if (!error) {
                NSNumber *count = [[NSNumber alloc] initWithUnsignedInteger:[results count]];
                [self.eventItems setObject:count forKey:@"memberCount"];
                [self.eventItems save];
            }
        }];
        [self.countText setText:[NSString stringWithFormat:@"%@ people in this event!", [self.eventItems objectForKey:@"memberCount"]]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Join successfully!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        PFRelation *inEventRelation = [user relationforKey:@"inEvent"];
        [inEventRelation addObject: self.eventItems];
        [user save];
    }
}


-(IBAction)verifyAttendance:(id)sender
{
    if (self.eventItems) {
        PFUser *user = [PFUser currentUser];
        PFRelation *inEventRelation = [user relationforKey:@"verifiedEvent"];
        [inEventRelation addObject: eventItems];
        [user save];
        PFRelation *eventRelation = [self.eventItems relationforKey:@"attendants"];
        PFQuery *query = [eventRelation query];
        [query whereKey:@"objectId" equalTo:user.objectId];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            // results contains photo for the group
            if (!error) {
                if ([results count] != 0) {
                    NSDate *today = [NSDate date];
                    double timeInterval = [today timeIntervalSinceDate:[self.eventItems objectForKey:@"eventDate"]];
                    if (abs((int)timeInterval) < 3600*6) {
                        CLLocation *location = [[JGLocationController sharedItem] currentLocation];
                        CLLocationCoordinate2D to = [location coordinate];
                        PFGeoPoint *eventGeoPoint = [self.eventItems objectForKey:@"locations"];
                        CLLocationCoordinate2D from = CLLocationCoordinate2DMake(eventGeoPoint.latitude, eventGeoPoint.longitude);
                        // adapted from C++ code on this page http://www.codecodex.com/wiki/Calculate_distance_between_two_points_on_a_globe
                        static const double DEG_TO_RAD = 0.017453292519943295769236907684886;
                        static const double EARTH_RADIUS_IN_METERS = 6372797.560856;
                        
                        double latitudeArc  = (from.latitude - to.latitude) * DEG_TO_RAD;
                        double longitudeArc = (from.longitude - to.longitude) * DEG_TO_RAD;
                        double latitudeH = sin(latitudeArc * 0.5);
                        latitudeH *= latitudeH;
                        double lontitudeH = sin(longitudeArc * 0.5);
                        lontitudeH *= lontitudeH;
                        double tmp = cos(from.latitude*DEG_TO_RAD) * cos(to.latitude*DEG_TO_RAD);
                        double dist = EARTH_RADIUS_IN_METERS * 2.0 * asin(sqrt(latitudeH + tmp*lontitudeH));
                        if (abs((int)dist) < 3000) {
                            NSNumber *count = [self.eventItems objectForKey:@"verifiedCount"];
                            PFRelation *verifiedRelation = [self.eventItems relationforKey:@"verifiedUser"];
                            [verifiedRelation addObject:user];
                            [self.eventItems save];
                            PFQuery *verifiedQuery = [verifiedRelation query];
                            [verifiedQuery findObjectsInBackgroundWithBlock:^(NSArray *verifiedResults, NSError *error) {
                                if (!error) {
                                    NSNumber *newCount = [[NSNumber alloc] initWithUnsignedInteger:[verifiedResults count]];
                                    [self.eventItems setObject:newCount forKey:@"verifiedCount"];
                                    [self.eventItems save];
                                    if ([newCount intValue] > [count intValue]) {
                                        NSNumber *prevCount = [self.groupItems objectForKey:@"ActivityCount"];
                                        NSUInteger i = [prevCount integerValue] + [newCount integerValue] - [count integerValue];
                                        NSNumber *num = [[NSNumber alloc] initWithUnsignedInteger:i];
                                        [self.groupItems setObject:num forKey:@"ActivityCount"];
                                        [self.groupItems save];
                                    }
                                }
                            }];
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Verified!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];
                        }
                        else {
                            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please arrive at the event first." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                            [alert show];

                        }
                    }
                    else {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please wait until the date of the event." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                        [alert show];
                    }
                }
                else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please join the event first." message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [alert show];
                }
            }
        }];

    }
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
    self.forumTableViewController = [[JGForumTableViewController alloc] init];
    [self.forumTableViewController.tableView setFrame:CGRectMake(0.0f, 44.0f, 320.0f, 400.0f)];
    [self.view addSubview:self.forumTableViewController.tableView];
    self.forumTableViewController.eventItems = self.eventItems;
    if (self.eventItems) {
        [self.countText setText:[NSString stringWithFormat:@"%@ people in this event!", [self.eventItems objectForKey:@"memberCount"]]];
    }
    else {
        [self.countText setText:[NSString stringWithFormat:@"No people in this event."]];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddNewPost"]) {
        JGForumAddPostViewController *addNewPostViewController = [segue destinationViewController];
        addNewPostViewController.eventItems = self.eventItems;
    }
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
