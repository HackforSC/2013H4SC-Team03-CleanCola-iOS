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

-(id)init{
    self = [super init];
    RKObjectMapping *postObjectMapping = [RKObjectMapping requestMapping];
    [postObjectMapping addAttributeMappingsFromDictionary:@{
     @"description": @"description",
     @"latitude": @"latitude",
     @"longitude": @"longitude",
     @"category_id": @"category_id",
     @"incident_id": @"id",
     @"title": @"title",
     @"date_created" :@"date_created",
     @"is_flagged": @"is_flagged",
     @"is_closed": @"is_closed",
     @"votes":@"votes"
     }];
    
    RKRequestDescriptor *requestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:postObjectMapping
                                                                                   objectClass:[Incident class] rootKeyPath:nil];
    
    [[RKObjectManager sharedManager] addRequestDescriptor: requestDescriptor];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:postObjectMapping pathPattern:nil keyPath:@"incidents" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    return self;
}
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
     //@"latlng" : @"latlng",
     @"description": @"description",
     @"id": @"incident_id",
     @"category_id" : @"category_id",
     @"date_created" : @"date_created",
     @"votes" : @"votes",
     @"is_closed" : @"is_closed",
     @"is_closed" : @"is_closed"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:incidentMapping pathPattern:nil keyPath:@"incident" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];
    
    NSString *urlString = @"http://api.cleancola.org/incidents";
    urlString = [urlString stringByAppendingPathComponent:incident_id];
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    RKObjectRequestOperation *objectRequestOperation = [[RKObjectRequestOperation alloc] initWithRequest:request responseDescriptors:@[ responseDescriptor ]];
    [objectRequestOperation setCompletionBlockWithSuccess:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        RKLogInfo(@"Load collection of Articles: %@", mappingResult.array);
        
        [delegate didLoadIncident:mappingResult.array];
        
    } failure:^(RKObjectRequestOperation *operation, NSError *error) {
        RKLogError(@"Operation failed with error: %@", error);
    }];
    [objectRequestOperation start];
}

-(void)refreshIncidents{
    [self loadIncidentsWithLocation];
}

-(void)makeNewReportWithIncident:(Incident *)inc Image:(UIImage *)image
{
    RKObjectMapping* incidentMapping = [RKObjectMapping mappingForClass:[Incident class]];
    [incidentMapping addAttributeMappingsFromDictionary:@{
     @"date_created": @"date_created",
     @"title" : @"title",
     @"description": @"description",
     @"id": @"incident_id",
     @"category_id" : @"category_id",
     @"date_created" : @"date_created",
     @"votes" : @"votes",
     @"is_closed" : @"is_closed",
     @"is_flagged" : @"is_flagged",
     @"votes" :@"votes",
     @"latitude": @"latitude",
     @"longitude": @"longitude"
     }];
    
    RKResponseDescriptor *responseDescriptor = [RKResponseDescriptor responseDescriptorWithMapping:incidentMapping pathPattern:@"/incidents" keyPath:@"incident" statusCodes:RKStatusCodeIndexSetForClass(RKStatusCodeClassSuccessful)];

    [[RKObjectManager sharedManager] addResponseDescriptor:responseDescriptor];

    //RKLogConfigureByName("RestKit", RKLogLevelWarning);
    //RKLogConfigureByName("RestKit/ObjectMapping", RKLogLevelTrace);
    RKLogConfigureByName("RestKit/Network", RKLogLevelTrace);

    [[RKObjectManager sharedManager] postObject:inc path:@"/incidents" parameters:nil success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
        [self saveImage:image Incident: mappingResult.array];
    }failure:nil];
    
    
    
    
//    RKObjectManager *objectManager = [RKObjectManager sharedManager];
//    NSMutableURLRequest *request =
//    [objectManager multipartFormRequestWithObject:inc method:RKRequestMethodPOST
//                                             path:@"/incidents" parameters:nil
//                        constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//     {
//         [formData appendPartWithFileData:UIImageJPEGRepresentation(image, 0.5)
//                                              name:@"image"
//                                          fileName:@"photo.png"
//                                          mimeType:@"image/png"];
//     }];
//    RKObjectRequestOperation *operation =
//    [objectManager objectRequestOperationWithRequest:request
//                                             success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult)
//     {
//         // Success handler.
//         NSLog(@"%@", [mappingResult firstObject]);
//     } failure:^(RKObjectRequestOperation *operation, NSError *error) {
//         // Error handler.
//     }];
//    
//    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation]; // NOTE: Must be enqueued rather than started
//    
//    
//    
    
    
    
    
}

-(void)saveImage:(UIImage *)image Incident:(NSArray *)inc{
    
    self.userImage = image;;
    // Configure a request mapping
    // Shortcut for [RKObjectMapping mappingForClass:[NSMutableDictionary class] ]
    //RKObjectMapping* chalkboardeRequestMapping = [RKObjectMapping requestMapping ];
    //    [chalkboardeRequestMapping addAttributeMappingsFromArray:@[ @"imageData" ]];
    
    // Now configure the request descriptor
    //RKRequestDescriptor *requestDescriptor2 = [RKRequestDescriptor requestDescriptorWithMapping:chalkboardeRequestMapping objectClass:[Incident class] rootKeyPath:@"incident"];
    NSString *path = @"";
    
    for (Incident *In in inc) {
        path = [[NSString alloc]initWithFormat:@"/incidents/%@/images", In.incident_id ];
    }
    // Serialize the Article attributes then attach a file
    NSMutableURLRequest *request = [[RKObjectManager sharedManager] multipartFormRequestWithObject:[inc objectAtIndex:0] method:RKRequestMethodPOST path:path parameters:nil constructingBodyWithBlock: ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.userImage, 0.5)
                                    name:@"image"
                                fileName:@"photo.png"
                                mimeType:@"image/png"];
    }];
    
    RKObjectRequestOperation *operation = [[RKObjectManager sharedManager] objectRequestOperationWithRequest:request success:nil failure:nil];
    [[RKObjectManager sharedManager] enqueueObjectRequestOperation:operation]; // NOTE: Must be enqueued rather than started
    
}

@end
