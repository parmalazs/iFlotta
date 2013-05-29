//
//  VehiclesDetailsViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "VehiclesDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface VehiclesDetailsViewController ()

@end

@implementation VehiclesDetailsViewController

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
    
    self.name.text = [self.siteData valueForKey:@"autoNev"];
    
    self.vehicleType.text = [self.siteData valueForKey:@"autoTipus"];
    self.speedometer.text = [self.siteData valueForKey:@"autoKilometerOra"];
    self.fuel.text = [self.siteData valueForKey:@"autoUzemAnyag"];
    //self.benzin.text = [self.siteData valueForKey:@"telephelyEmail"];
    self.tipus.text = [self.siteData valueForKey:@"autoRendszam"];
    self.km.text = [self.siteData valueForKey:@"autoKilometerOra"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
