//
//  ViewController.m
//  CleanCola
//
//  Created by Marvin on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init Core Location
    CLController = [[CLLocationManager alloc] init];
    CLController.delegate = self;
    CLController.desiredAccuracy = kCLLocationAccuracyKilometer;
    CLController.distanceFilter = 500;
    
    
}


-(void)startLocatingUser
{
    //Find user's location
    if([CLLocationManager locationServicesEnabled] == YES && [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied){
        [CLController startUpdatingLocation];
    }
    else{
        //rm._reloading = NO;
        noLocation = YES;
        //[self.specialTable reloadData];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    NSDate* eventDate = newLocation.timestamp;
    NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];
    if (abs(howRecent) < 15.0)
    {
        //[self.imageDownloadsInProgress removeAllObjects];
        
       // [HUD show:YES];
        CGPoint location = CGPointMake(newLocation.coordinate.latitude, newLocation.coordinate.longitude);
        lastLocation = location;
        //[rm loadSpecialsWithLocation:location distance:self.filterDistance day:self.filterDay];
        //rm._reloading = YES;
        [CLController stopUpdatingLocation];
    }
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"Location error");
   // rm._reloading = NO;
    noLocation = YES;
  //  [HUD hide:YES];
    //[self.specialTable reloadData];
}

- (void)locationError:(NSError *)error {
	NSLog(@"Encountered an error: %@", error);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openReportView:(id)sender {
    ReportViewController *RVC = [[ReportViewController alloc]init];
    [self presentViewController:RVC animated:TRUE completion:nil];
}
@end
