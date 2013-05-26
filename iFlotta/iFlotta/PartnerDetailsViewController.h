//
//  PartnerDetailsViewController.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerDetailsViewController : UIViewController
@property (nonatomic, strong) NSManagedObject *partnerData;
@property (weak, nonatomic) IBOutlet UILabel *partnerNev;
@property (weak, nonatomic) IBOutlet UILabel *partnerCim;
@property (weak, nonatomic) IBOutlet UILabel *partnerTelefonszam;
@property (weak, nonatomic) IBOutlet UILabel *PartnerEmail;

@end
