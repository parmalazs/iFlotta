//
//  DriverDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "DriverDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
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
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
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
