//
//  ReportViewController.h
//  CleanCola
//
//  Created by Jason Rikard on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentManager.h"
#import "Incident.h"

@interface ReportViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIActionSheetDelegate>


@property (weak, nonatomic) IBOutlet UITextField *reportTitle;
@property (weak, nonatomic) IBOutlet UITextView *description;

- (IBAction)SubmitReport:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIImageView *photo;
- (IBAction)cancelButton:(id)sender;
@property (nonatomic, retain) UIImage *userImage;
@end
