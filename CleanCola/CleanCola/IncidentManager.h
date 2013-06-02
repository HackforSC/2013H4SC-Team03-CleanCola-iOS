//
//  IncidentManager.h
//  CleanCola
//
//  Created by Jason Rikard on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RestKit/RestKit.h>
#import "Incident.h"

@protocol IncidentDelegate <NSObject>

@required
- (void)didLoadWithError:(NSError *)error;

@optional
//- (void)didLoadIncident:(Incident *)incident;
- (void)didLoadIncidents:(NSArray *)incidents;
- (void)didLoadIncident:(NSArray *)incidents;

@end
@interface IncidentManager : NSObject{
    BOOL _reloading;
}

@property (nonatomic, retain) id <IncidentDelegate> delegate;
@property (nonatomic) BOOL _reloading;

//-(void)loadSpecialsWithLocation:(CGPoint)location distance:(NSNumber *)distance;
//-(void)loadSpecialsWithLocation:(CGPoint)location distance:(NSNumber *)distance day:(NSString*)day;
//-(void)loadSpecialWithSpecialID:(NSString *)specialID;
//-(void)loadSpecialsWithRestaurantID:(NSString *)restaurantID;

-(void)refreshIncidents;
-(void)makeNewReportWithIncident:(Incident *)inc;
- (void)loadIncidentWithId:(NSString *)incident_id;
@end
