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
    
    RMMapBoxSource *source = [[RMMapBoxSource alloc] initWithMapID:@"cleancola.map-rmhk6v1q"];
    self.mapView = [[RMMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height/3*2) andTilesource:source];
    [self.view addSubview:self.mapView];
    
    self.mapView.zoom = 11.5;
    
    CLLocationDegrees latitude = 34.002;
    CLLocationDegrees longitude = -81.03;
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(latitude, longitude);
    
    self.mapView.centerCoordinate = location;
    
    NSLog(@"%f", self.mapView.centerCoordinate.latitude);
    NSLog(@"%f", self.mapView.centerCoordinate.longitude);
    
    
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
}
@end
