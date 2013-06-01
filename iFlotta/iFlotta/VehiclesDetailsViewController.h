//
//  VehiclesDetailsViewController.h
//  iFlott
//
//  Created by hallgato1 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehiclesDetailsViewController : UIViewController
@property (nonatomic, strong) NSManagedObject *adatDetails;

@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *vehicleType;
@property (strong, nonatomic) IBOutlet UILabel *speedometer;
@property (strong, nonatomic) IBOutlet UILabel *fuel;

@property (strong, nonatomic) IBOutlet UIImageView *mapImage;

@property (strong, nonatomic) IBOutlet UILabel *benzin;
@property (strong, nonatomic) IBOutlet UILabel *tipus;
@property (strong, nonatomic) IBOutlet UILabel *km;
- (IBAction)foglalasButtonPushed:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *profilImage;
@end
