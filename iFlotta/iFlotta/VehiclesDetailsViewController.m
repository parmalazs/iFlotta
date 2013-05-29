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
    
    self.name.text = [self.adatDetails valueForKey:@"autoNev"];
    self.vehicleType.text = [self.adatDetails valueForKey:@"autoTipus"];
    //self.speedometer.text = [self.adatDetails valueForKey:@"autoKilometerOra"];
    //self.fuel.text = [self.adatDetails valueForKey:@"autoUzemAnyag"];
    //self.benzin.text = [self.siteData valueForKey:@"telephelyEmail"];
    self.tipus.text = [self.adatDetails valueForKey:@"autoRendszam"];
    //self.km.text = [self.adatDetails valueForKey:@"autoKilometerOra"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
