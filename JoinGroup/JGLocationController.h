//
//  JGLocationController.h
//  JoinGroup
//
//  Created by user on 3/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//
//  Based on http://stackoverflow.com/questions/459355/whats-the-easiest-way-to-get-the-current-location-of-an-iphone
//  by Brad Smith and Jason Plank

#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface JGLocationController : NSObject <CLLocationManagerDelegate> {
    CLLocationManager *locationManager;
    CLLocation *currentLocation;
}

+ (JGLocationController *) sharedItem;

- (void) start;
- (void) stop;
- (BOOL) noUpdated;

@property (nonatomic, retain) CLLocation *currentLocation;

@end
