//
//  ReportViewController.m
//  CleanCola
//
//  Created by Jason Rikard on 6/1/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import "ReportViewController.h"

@interface ReportViewController ()

@end

@implementation ReportViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
}



- (IBAction)SubmitReport:(id)sender {
    Incident *inc = [[Incident alloc]init];
    IncidentManager *im = [[IncidentManager alloc]init];
    inc.description = self.description.text;
    inc.title = self.reportTitle.text;
    inc.latitude = @"0";
    inc.longitude = @"0";
    inc.category_id = @"1";
    inc.image = self.userImage;
    [im makeNewReportWithIncident:inc];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)cancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        //self.description = textView.text;
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (void)startCamera
{
    UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
    imagePickController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickController.delegate=self;
    imagePickController.allowsEditing=NO;
    [self presentModalViewController:imagePickController animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.userImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.photo setImage:self.userImage];
    [self dismissModalViewControllerAnimated:YES];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //Get the name of the current pressed button
    NSString *buttonTitle = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([buttonTitle isEqualToString:@"Take Photo"]) {
        NSLog(@"Take Photo");
        [self startCamera];
    }
    if ([buttonTitle isEqualToString:@"Choose From Library"]) {
        UIImagePickerController *imagePickController=[[UIImagePickerController alloc]init];
        imagePickController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        imagePickController.delegate=self;
        imagePickController.allowsEditing=NO;
        [self presentModalViewController:imagePickController animated:YES];
        
    }
    if ([buttonTitle isEqualToString:@"Cancel Button"]) {
        NSLog(@"Cancel pressed --> Cancel ActionSheet");
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.photo)
    {
        [self choosePhoto:self];
    }
    
}


- (IBAction)choosePhoto:(id)sender {
    NSString *actionSheetTitle = @"Add Photo"; //Action Sheet Title
    NSString *other1 = @"Take Photo";
    NSString *other2 = @"Choose From Library";
    NSString *cancelTitle = @"Cancel";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:actionSheetTitle
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2, nil];
    [actionSheet showInView:self.view];
}



@end
