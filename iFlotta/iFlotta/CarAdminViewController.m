//
//  CarAdminViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "CarAdminViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CarAdminViewController ()

@end

@implementation CarAdminViewController

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
    
    self.carNameLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.carNameLabel.textColor= UIColorFromRGB(0xFFFFFF);
    
    self.carTypeLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carTypeLabel.textColor = UIColorFromRGB(0xFFFFFF);

    self.carSpeedometerLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carSpeedometerLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.carRendszamLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carRendszamLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.carMuszakiLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carMuszakiLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.carServiceLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carServiceLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.carXLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carXLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.carYLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carYLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.carFuelLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carFuelLabel.textColor = UIColorFromRGB(0xFFFFFF);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender {
}

- (IBAction)saveButton:(id)sender {
    
}
@end
