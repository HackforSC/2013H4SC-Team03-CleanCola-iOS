//
//  IncidentViewController.h
//  CleanCola
//
//  Created by Marvin on 6/2/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentManager.h"
#import <FlatUIKit/FUIButton.h>
#import <FlatUIKit/UIColor+FlatUI.h>
#import <FlatUIKit/UIFont+FlatUI.h>
#import <FlatUIKit/UIImage+FlatUI.h>
#import <FlatUIKit/UIStepper+FlatUI.h>
#import <FlatUIKit/UINavigationBar+FlatUI.h>
#import <FlatUIKit/UIBarButtonItem+FlatUI.h>
#import "NSDate+Helper.h"

@interface IncidentViewController : UIViewController<IncidentDelegate>

//Incident properties
@property (nonatomic, strong) NSString *incident_id;
@property (nonatomic, strong) NSString *incident_title;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *category;
@property (nonatomic, strong) NSString *latlng;
@property (nonatomic, strong) NSDate *date_created;
@property (nonatomic, assign) int votes;
@property (nonatomic, assign) BOOL is_closed;
@property (nonatomic, assign) BOOL is_flagged;

@property (nonatomic, strong) UIImage *image;

@property (nonatomic, strong) IBOutlet UIStepper *stepper;
@property (nonatomic, strong) IBOutlet UILabel *descrLbl;
@property (nonatomic, strong) IBOutlet UILabel *dateLbl;
@property (nonatomic, strong) IBOutlet UILabel *votesLbl;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet FUIButton *closeButton;

@property (nonatomic, strong) IncidentManager *incidentMgr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil incident_id:(NSString *)incident_id;

@end
