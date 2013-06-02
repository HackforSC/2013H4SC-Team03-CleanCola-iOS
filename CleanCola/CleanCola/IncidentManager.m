//
//  IncidentManager.m
//  CleanCola
//
//  Created by Jason Rikard on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import "IncidentManager.h"

@implementation IncidentManager
@synthesize _reloading, delegate;

- (void)loadIncidentsWithLocation
{
    RKObjectMapping* incidentMapping = [RKObjectMapping mappingForClass:[Incident class]];
    [incidentMapping addAttributeMappingsFromDictionary:@{
     @"date_created": @"date_created",
     @"description": @"description",
     @"id": @"incident_id",
     @"category_id" : @"category_id",
     @"latitude": @"latitude",
     @"longitude": @"longitude"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:incidentMapping pathPattern:nil keyPath:@"incidents" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:@"http://api.cleancola.org/incidents"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
    
        [delegate didLoadIncidents:mappingResult.array];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    [objectRequestOperation start];
}

- (void)loadIncidentWithId:(NSString *)incident_id
{
    RKObjectMapping* incidentMapping = [RKObjectMapping mappingForClass:[Incident class]];
    [incidentMapping addAttributeMappingsFromDictionary:@{
     @"date_created": @"date_created",
     @"title" : @"title",
     @"latlng" : @"latlng",
     @"description": @"description",
     @"incident_id": @"incident_id",
     @"date_created" : @"date_created",
     @"votes" : @"votes",
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:incidentMapping pathPattern:nil keyPath:@"incidents" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:@"http://api.cleancola.org/incidents"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
        
        [delegate didLoadIncidents:mappingResult.array];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    [objectRequestOperation start];
}

-(void)refreshIncidents{
    [self loadIncidentsWithLocation];
}

-(void)makeNewReportWithIncident:(Incident *)inc 
{
    RKObjectMapping *postObjectMapping = [RKObjectMapping requestMapping];
    [postObjectMapping addAttributeMappingsFromDictionary:@{
     @"date_created": @"date_created",
     @"description": @"description",
     @"incident_id": @"incident_id",
     @"latitude": @"latitude",
     @"longitude": @"longitude",
     @"category_id": @"category_id",
     @"image": @"image;"
     }];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:postObjectMapping
                                                                                   objectClass:[Incident class] rootKeyPath:nil];
    
    [[RKObjectManager sharedManager] addRequestDescriptor: requestDescriptor];
    

    //RKLogConfigureByName("RestKit", RKLogLevelWarning);
    //RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);

    [[RKObjectManager sharedManager] postObject:inc path:@"/incidents" parameters:nil success:nil failure:nil];
}
@end
