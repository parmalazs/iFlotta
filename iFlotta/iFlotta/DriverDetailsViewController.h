//
//  DriverDetailsViewController.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverDetailsViewController : UIViewController
@property (nonatomic, strong) NSManagedObject *driverData;
@property (weak, nonatomic) IBOutlet UILabel *soforNev;
@property (weak, nonatomic) IBOutlet UILabel *soforCim;
@property (weak, nonatomic) IBOutlet UILabel *soforTelefonszam;
@property (weak, nonatomic) IBOutlet UILabel *soforEmail;

@end
