//
//  JGGroupDetailViewController.h
//  JoinGroup
//
//  Created by user on 3/14/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <MapKit/MapKit.h>
#import "JGLocationController.h"
#import "GeoPointAnnotation.h"

@interface JGGroupDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *distLabel;
@property (strong, nonatomic) id groupItems;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *groupTitle;
@property (weak, nonatomic) IBOutlet UILabel *groupDetails;
@property (weak, nonatomic) IBOutlet UIImageView *groupImageView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *hereButton;
- (IBAction)join:(id)sender;
- (IBAction)findCurrent:(id)sender;
@end
