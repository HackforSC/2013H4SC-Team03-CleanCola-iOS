//
//  IncidentViewController.m
//  CleanCola
//
//  Created by Marvin on 6/2/13.
//  Copyright (c) 2013 SCHackDay. All rights reserved.
//

#import "IncidentViewController.h"

@interface IncidentViewController ()

@end

@implementation IncidentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil incident_id:(NSString *)incident_id
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.incident_id = incident_id;
        
        self.incidentMgr = [[IncidentManager alloc] init];
        self.incidentMgr.delegate = self;
        [self.incidentMgr loadIncidentWithId:self.incident_id];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor cloudsColor];
    
    self.closeButton.buttonColor = [UIColor emerlandColor];
    self.closeButton.shadowColor = [UIColor nephritisColor];
    self.closeButton.shadowHeight = 3.0f;
    self.closeButton.cornerRadius = 6.0f;
    self.closeButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.closeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    
    self.votesLbl.font = [UIFont boldFlatFontOfSize:20.0];
    self.votesLbl.textColor = [UIColor midnightBlueColor];
    
    self.dateLbl.font = [UIFont flatFontOfSize:17.0];
    self.dateLbl.textColor = [UIColor midnightBlueColor];
    
    self.descrLbl.font = [UIFont flatFontOfSize:17.0];
    self.descrLbl.textColor = [UIColor midnightBlueColor];
    
    [self.stepper configureFlatStepperWithColor:[UIColor nephritisColor] highlightedColor:[UIColor nephritisColor] disabledColor:[UIColor emerlandColor] iconColor:[UIColor cloudsColor]];
    
    [self.navBar configureFlatNavigationBarWithColor:[UIColor midnightBlueColor]];
    
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor peterRiverColor]
                                  highlightedColor:[UIColor belizeHoleColor]
                                      cornerRadius:3
                                   whenContainedIn:[self class]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didLoadWithError:(NSError *)error
{
    NSLog(@"Jinkees!");
}

- (void)didLoadIncident:(NSArray *)incidents
{
    for (Incident *In in incidents)
    {
        self.incident_title = In.title;
        self.description = In.description;
        self.date_created = In.date_created;
        self.votes = In.votes;
        if (In.is_closed != nil)
        {
            self.is_closed = YES;
        }
        else
        {
            self.is_closed = NO;
        }
        if (In.is_flagged != nil)
        {
            self.is_flagged = YES;
        }
        else
        {
            self.is_flagged = NO;
        }
    }
    self.title = self.incident_title;
    self.votesLbl.text = [NSString stringWithFormat:@"%d", self.votes];
    self.dateLbl.text = [NSDate stringForDisplayFromDate:self.date_created];
    self.descrLbl.text = self.description;
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)valueChanged:(UIStepper *)sender
{
    double value = [sender value];
    self.stepper.enabled = NO;
    [self.votesLbl setText:[NSString stringWithFormat:@"%d", (int)value]];
}

- (IBAction)taskCompleted:(id)sender
{
    [self.closeButton setTitle:@"Task Completed!" forState:UIControlStateDisabled];
    self.closeButton.enabled = NO;
    self.closeButton.buttonColor = [UIColor alizarinColor];
    self.closeButton.shadowColor = [UIColor pomegranateColor];
    self.closeButton.shadowHeight = 3.0f;
    self.closeButton.cornerRadius = 6.0f;
    self.closeButton.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [self.closeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.closeButton setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
}

@end
