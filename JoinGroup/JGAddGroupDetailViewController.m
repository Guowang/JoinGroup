//
//  JGAddGroupDetailViewController.m
//  JoinGroup
//
//  Created by Meng Qi on 3/16/13.
//  Copyright (c) 2013 user. All rights reserved.
//
#import "JGAddGroupDetailViewController.h"

@interface JGAddGroupDetailViewController ()

@end

@implementation JGAddGroupDetailViewController
@synthesize titleInput, detailsInput, groupIdCreated;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.titleInput || textField == self.detailsInput) {
        [textField resignFirstResponder];
    }
    return YES;
}
-(IBAction)creatGroup:(id)sender
{
    if ([self.titleInput.text length]) {
        NSDate *today = [NSDate date];
        NSNumber *count = [[NSNumber alloc] initWithInt:1];
        NSNumber *count0 = [[NSNumber alloc] initWithInt:0];
        PFUser *user = [PFUser currentUser];
        CLLocation *location = [[JGLocationController sharedItem] currentLocation];
        CLLocationCoordinate2D coordinate = [location coordinate];
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
        PFObject *groupObject = [PFObject objectWithClassName:@"Group"];
        [groupObject setObject:self.titleInput.text forKey:@"Title"];
        [groupObject setObject:self.detailsInput.text forKey:@"Details"];
        [groupObject setObject:today forKey:@"addedDate"];
        [groupObject setObject:geoPoint forKey:@"Locations"];
        [groupObject setObject:count forKey:@"MemberCount"];
        [groupObject setObject:count0 forKey:@"ActivityCount"];
        [groupObject save];
        PFRelation *memberRelation = [groupObject relationforKey:@"Members"];
        [memberRelation addObject:user];
        [groupObject save];
        PFRelation *relation = [user relationforKey:@"Membership"];
        [relation addObject:groupObject];
        [user save];
        groupIdCreated = groupObject.objectId;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.titleInput setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
    [self.detailsInput setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"text.png"]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
