//
//  DriverDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "DriverDetailsViewController.h"

@interface DriverDetailsViewController ()

@end

@implementation DriverDetailsViewController

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
    self.soforNev.text = [self.driverData valueForKey:@"soforNev"];
    self.soforCim.text = [self.driverData valueForKey:@"soforCim"];
    self.soforTelefonszam.text = [self.driverData valueForKey:@"soforTelefonszam"];
    self.soforEmail.text = [self.driverData valueForKey:@"soforEmail"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
