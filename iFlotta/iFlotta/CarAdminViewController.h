//
//  CarAdminViewController.h
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarAdminViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *carNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *carTypeTextField;
@property (strong, nonatomic) IBOutlet UITextField *carSpeedometerTextField;
@property (strong, nonatomic) IBOutlet UITextField *carFuelTextField;
@property (strong, nonatomic) IBOutlet UITextField *carRendszamTextField;
@property (strong, nonatomic) IBOutlet UITextField *carMuszakiTextField;
@property (strong, nonatomic) IBOutlet UITextField *carServiceTextField;
@property (strong, nonatomic) IBOutlet UITextField *carXTextField;
@property (strong, nonatomic) IBOutlet UITextField *carYTextField;

@property (strong, nonatomic) IBOutlet UILabel *carNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *carTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *carSpeedometerLabel;
@property (strong, nonatomic) IBOutlet UILabel *carFuelLabel;
@property (strong, nonatomic) IBOutlet UILabel *carRendszamLabel;
@property (strong, nonatomic) IBOutlet UILabel *carMuszakiLabel;
@property (strong, nonatomic) IBOutlet UILabel *carServiceLabel;
@property (strong, nonatomic) IBOutlet UILabel *carXLabel;
@property (strong, nonatomic) IBOutlet UILabel *carYLabel;


@end