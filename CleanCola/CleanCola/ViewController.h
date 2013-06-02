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
#import <FlatUIKit/UINavigationBar+FlatUI.h>
#import <FlatUIKit/UIBarButtonItem+FlatUI.h>
#import "IncidentManager.h"
#import "CCMarker.h"

@interface ViewController : UIViewController <CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, IncidentDelegate, RMMapViewDelegate>{
    CLLocationManager *CLController;
    BOOL noLocation;
    BOOL useNearbyLocation;
    CGPoint lastLocation;
    IncidentManager *IManager;
}

@property (nonatomic, strong) RMMapView *mapView;
@property (weak, nonatomic) IBOutlet FUIButton *mybutton;
@property (nonatomic, strong) IBOutlet FUIButton *refineButton;

- (IBAction)openReportView:(id)sender;
- (IBAction)refineMapItems:(id)sender;

@end