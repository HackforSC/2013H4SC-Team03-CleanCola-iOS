//
//  ReportViewController.h
//  CleanCola
//
//  Created by Jason Rikard on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FlatUIKit/FUIButton.h>
#import <FlatUIKit/UIColor+FlatUI.h>
#import <FlatUIKit/UIFont+FlatUI.h>
#import <FlatUIKit/UIImage+FlatUI.h>
#import <FlatUIKit/UIStepper+FlatUI.h>
#import <FlatUIKit/UINavigationBar+FlatUI.h>
#import <FlatUIKit/UIBarButtonItem+FlatUI.h>
#import "IncidentManager.h"
#import "Incident.h"

@interface ReportViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@property (nonatomic, strong) IBOutlet FUIButton *submitButton;
@property (nonatomic, strong) IBOutlet UINavigationBar *navBar;
@property (nonatomic, strong) IBOutlet UIBarButtonItem *barButton;

@property (weak, nonatomic) IBOutlet UITextField *reportTitle;
@property (weak, nonatomic) IBOutlet UITextView *description;

- (IBAction)SubmitReport:(id)sender;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
- (IBAction)cancelButton:(id)sender;
@property (nonatomic, retain) UIImage *userImage;
@property (nonatomic) CGPoint lastLocation;

@end
