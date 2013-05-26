//
//  PartnerDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "PartnerDetailsViewController.h"

@interface PartnerDetailsViewController ()

@end

@implementation PartnerDetailsViewController

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
    self.partnerNev.text = [self.partnerData valueForKey:@"partnerNev"];
    self.partnerCim.text = [self.partnerData valueForKey:@"partnerCim"];
    self.partnerTelefonszam.text = [self.partnerData valueForKey:@"partnerTelefonszam"];
    self.PartnerEmail.text = [self.partnerData valueForKey:@"partnerEmailcim"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
