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
    
}

@end
