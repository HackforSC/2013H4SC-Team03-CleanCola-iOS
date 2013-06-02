//
//  Incident.h
//  CleanCola
//
//  Created by Jason Rikard on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Incident : NSObject

@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* incident_id;
@property (nonatomic, copy) NSString* category_id;
@property (nonatomic, copy) NSString* description;
@property (nonatomic, copy) NSString* latitude;
@property (nonatomic, copy) NSString* longitude;
@property (nonatomic, assign) int votes;
@property (nonatomic, copy) UIImage* image;
@property (nonatomic, copy) NSString* is_flagged;
@property (nonatomic, copy) NSString* is_closed;
@property (nonatomic, copy) NSString* votes;

@property (nonatomic, strong) NSDate* date_created;
@property (nonatomic, strong) NSDate* is_closed;
@property (nonatomic, strong) NSDate* is_flagged;

@end
