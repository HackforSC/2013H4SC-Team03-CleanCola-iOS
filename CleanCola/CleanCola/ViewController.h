//
//  ViewController.h
//  CleanCola
//
//  Created by Marvin on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapBox/MapBox.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    CLLocationManager *CLController;
    BOOL noLocation;
    BOOL useNearbyLocation;
    CGPoint lastLocation;
}

@property (nonatomic, strong) RMMapView *mapView;

- (IBAction)openReportView:(id)sender;

@end