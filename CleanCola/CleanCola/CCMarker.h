//
//  CCMarker.h
//  CleanCola
//
//  Created by Marvin on 6/2/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import "RMMarker.h"
#import <RMAnnotation.h>

@interface CCMarker : RMAnnotation

@property (nonatomic, strong) NSString *incident_id;
@property (nonatomic, strong) NSString *category_id;

@end
