//
//  JGGroupDetailViewController.m
//  JoinGroup
//
//  Created by user on 3/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//
// Parse.com: Geolocations https://www.parse.com/tutorials/geolocations

#import "JGGroupDetailViewController.h"
#import <Parse/Parse.h>
@interface JGGroupDetailViewController ()

@end

@implementation JGGroupDetailViewController
@synthesize distLabel;
@synthesize groupItems;
@synthesize mapView;
@synthesize groupTitle;
@synthesize groupDetails;
@synthesize groupImageView;
@synthesize hereButton;
- (IBAction)back:(UIStoryboardSegue *)segue
{
    
}

- (IBAction)join:(id)sender {
    if (self.groupItems) {
        PFUser *user = [PFUser currentUser];
        PFRelation *memberRelation = [self.groupItems relationforKey:@"Members"];
        [memberRelation addObject:user];
        [self.groupItems save];
        PFQuery *query = [memberRelation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            int c = [results count];
            NSNumber *count = [[NSNumber alloc] initWithInt:c];
            [self.groupItems setObject:count forKey:@"MemberCount"];
            [self.groupItems save];
        }];
        PFRelation *relation = [user relationforKey:@"Membership"];
        [relation addObject:self.groupItems];
        [user save];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Join successfully!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

- (IBAction)findCurrent:(id)sender {
    if (groupItems) {
        CLLocation *location = [[JGLocationController sharedItem] currentLocation];
        CLLocationCoordinate2D coordinate = [location coordinate];
        PFGeoPoint *geoPoint = [PFGeoPoint geoPointWithLatitude:coordinate.latitude
                                                      longitude:coordinate.longitude];
        PFObject *groupObj = groupItems;
        // obtain the geopoint for group
        PFGeoPoint *groupGeoPoint = [groupObj objectForKey:@"Locations"];
        double dist = 2*MAX(abs(geoPoint.latitude*1e6 - groupGeoPoint.latitude*1e6), abs(geoPoint.longitude*1e6 - groupGeoPoint.longitude*1e6))/1e6;
        dist = MAX(dist, 0.004f);
        // center our map view around this geopoint
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(dist, dist));
        
        PFObject *currentObj = [PFObject objectWithClassName:@"Group"];
        [currentObj setObject:@"Here" forKey:@"Title"];
        [currentObj setObject:[NSDate date] forKey:@"addedDate"];
        [currentObj setObject:geoPoint forKey:@"Locations"];
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:currentObj];
        [self.mapView addAnnotation:annotation];
        
        CLLocationCoordinate2D to = [location coordinate];
        CLLocationCoordinate2D from = CLLocationCoordinate2DMake(groupGeoPoint.latitude, groupGeoPoint.longitude);
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
        double groupDist = EARTH_RADIUS_IN_METERS * 2.0 * asin(sqrt(latitudeH + tmp*lontitudeH));
        NSString *text = [[NSString alloc] initWithFormat:@"%d meters away!", (int)groupDist];
        [self.distLabel setText:text];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        if (groupItems) {
            PFObject *groupObj = groupItems;
            
            // obtain the geopoint for group
            PFGeoPoint *geoPoint = [groupObj objectForKey:@"Locations"];
            
            // center our map view around this geopoint
            self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //[self.hereButton setTitle:@""];
    //UIImage *image = [UIImage imageNamed:@"here_1.png"];
    //UIImage *aImg = [image stretchableImageWithLeftCapWidth:0 topCapHeight:0];
    //[self.hereButton setBackgroundImage:aImg forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    if (groupItems) {
        PFObject *groupObj = groupItems;
        [self.groupTitle setText:[groupObj objectForKey:@"Title"]];
        [self.groupDetails setText:[groupObj objectForKey:@"Details"]];
        // obtain the geopoint for group
        PFGeoPoint *geoPoint = [groupObj objectForKey:@"Locations"];
        
        // add the annotation
        GeoPointAnnotation *annotation = [[GeoPointAnnotation alloc] initWithObject:groupObj];
        [self.mapView addAnnotation:annotation];
        
        // center our map view around this geopoint
        self.mapView.region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(geoPoint.latitude, geoPoint.longitude), MKCoordinateSpanMake(0.01f, 0.01f));
        
        // load the group photo
        PFRelation *groupPhotoRelation = [groupObj relationforKey:@"Photo"];
        PFQuery *query = [groupPhotoRelation query];
        [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
            // results contains photo for the group
            // NSLog(@"there are %d photos for the group", [results count]);
            
            if (!error && [results count] != 0) {
                
                // At this point, object has been downloaded, but the PFFile was not included
                
                //Find the photo object and it's Thumbnail
                
                PFObject *photoObject = [results objectAtIndex:0];
                PFFile *imageFile = [photoObject objectForKey:@"ThumbnailFile"];
                [imageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error) {
                        //reform the image by the image data in Parse
                        UIImage *image = [UIImage imageWithData:data];
                        [groupImageView setImage:image];
                        [groupImageView setNeedsDisplay];
                    }
                }];
            }
        }];
        [self.distLabel setText:@"Group may be close..."];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationMaskPortrait);
}


#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    static NSString *GeoPointAnnotationIdentifier = @"RedPin";
    
    MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:GeoPointAnnotationIdentifier];
    
    if (!annotationView) {
        annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:GeoPointAnnotationIdentifier];
        annotationView.pinColor = MKPinAnnotationColorRed;
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.animatesDrop = YES;
    }
    
    return annotationView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
