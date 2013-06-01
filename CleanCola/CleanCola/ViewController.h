//
//  ViewController.h
//  CleanCola
//
//  Created by Marvin on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>{
    CLLocationManager *CLController;
    BOOL noLocation;
    BOOL useNearbyLocation;
    CGPoint lastLocation;
}



- (IBAction)openReportView:(id)sender;
@end