//
//  ReportViewController.h
//  CleanCola
//
//  Created by Jason Rikard on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IncidentManager.h"

@interface ReportViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)SubmitReport:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)cancelButton:(id)sender;
@end
