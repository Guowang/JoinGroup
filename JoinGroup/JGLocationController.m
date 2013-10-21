//
//  JGLocationController.m
//  JoinGroup
//
//  Created by user on 3/18/13.
//  Copyright (c) 2013 user. All rights reserved.
//

#import "JGLocationController.h"

@implementation JGLocationController

@synthesize currentLocation;

static JGLocationController *sharedItem;

+ (JGLocationController *)sharedItem {
    @synchronized(self) {
        if (!sharedItem)
            sharedItem = [[JGLocationController alloc] init];
    }
    return sharedItem;
}

+(id)alloc {
    @synchronized(self) {
        sharedItem = [super alloc];
    }
    return sharedItem;
}

-(id) init {
    if (self = [super init]) {
        self.currentLocation = [[CLLocation alloc] init];
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        [self start];
    }
    return self;
}

-(void) start {
    [locationManager startUpdatingLocation];
}

-(void) stop {
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
        self.currentLocation = newLocation;
}

@end
