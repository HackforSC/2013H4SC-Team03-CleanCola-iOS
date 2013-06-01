//
//  ViewController.h
//  CleanCola
//
//  Created by Marvin on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "ReportViewController.h"
#import <MapBox/MapBox.h>
#import <FlatUIKit/FUIButton.h>
#import <FlatUIKit/UIColor+FlatUI.h>
#import <FlatUIKit/UIFont+FlatUI.h>
#import <FlatUIKit/UIImage+FlatUI.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    CLLocationManager *CLController;
    BOOL noLocation;
    BOOL useNearbyLocation;
    CGPoint lastLocation;
}

@property (nonatomic, strong) RMMapView *mapView;
@property (nonatomic, strong) FUIButton *myButton;

- (IBAction)openReportView:(id)sender;

@end