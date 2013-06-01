//
//  PartnerDetailsViewController.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "CSVUtil.h"

@interface PartnerDetailsViewController : UIViewController <MFMailComposeViewControllerDelegate> { }
@property (nonatomic, strong) NSManagedObject *partnerData;
@property (weak, nonatomic) IBOutlet UILabel *partnerNev;
@property (weak, nonatomic) IBOutlet UILabel *partnerCim;
@property (weak, nonatomic) IBOutlet UILabel *partnerTelefonszam;
@property (weak, nonatomic) IBOutlet UILabel *PartnerEmail;

@property (strong, nonatomic) IBOutlet UILabel *nevLabel;
@property (strong, nonatomic) IBOutlet UILabel *telLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilImage;
- (IBAction)callPartner:(id)sender;
- (IBAction)messagePartner:(id)sender;

@end
