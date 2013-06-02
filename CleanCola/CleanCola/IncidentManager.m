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
     @"incident_id": @"incident_id",
     @"latitude": @"latitude",
     @"longitude": @"longitude"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:incidentMapping pathPattern:nil keyPath:@"incidents" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSURL *URL = [NSURL URLWithString:@"http://api.cleancola.org/v1/incidents"];
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
    inc.description = @"This is my new article!";
    inc.category_id = @"0";
    inc.latitude = @"-81.1";
    inc.longitude = @"34.0906";
    

    [[RKObjectManager sharedManager] postObject:inc path:@"/v1/incidents" parameters:nil success:nil failure:nil];
}
@end
