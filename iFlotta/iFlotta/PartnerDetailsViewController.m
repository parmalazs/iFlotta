//
//  PartnerDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "PartnerDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface PartnerDetailsViewController ()

@end

@implementation PartnerDetailsViewController

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
    self.view.backgroundColor=UIColorFromRGB(0xA6977C);
    
    self.partnerNev.text            = [self.partnerData valueForKey:@"partnerNev"];
    self.partnerCim.text            = [self.partnerData valueForKey:@"partnerCim"];
    self.partnerTelefonszam.text    = [self.partnerData valueForKey:@"partnerTelefonszam"];
    self.PartnerEmail.text          = [self.partnerData valueForKey:@"partnerEmailcim"];
    
    self.partnerCim.backgroundColor         = UIColorFromRGB(0xD9B384);
    self.partnerNev.backgroundColor         = UIColorFromRGB(0x260B01);
    self.partnerNev.textColor               = UIColorFromRGB(0xD9B384);
    self.partnerTelefonszam.backgroundColor = UIColorFromRGB(0xD9B384);
    self.PartnerEmail.backgroundColor       = UIColorFromRGB(0xD9B384);
    
    /// ezek a labelek
    self.nevLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.nevLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.telLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.telLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.emailLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.emailLabel.textColor       = UIColorFromRGB(0xFFFFFF);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callPartner:(id)sender {
    NSString *dial=[[NSString alloc] init];
    dial=@"telprompt://";
    NSString *number=[[NSString alloc] init];
    number=[self.partnerData valueForKey:@"partnerTelefonszam"];
    NSLog([NSString stringWithFormat:@"%@%@", dial, number]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", dial, number]]];
}

- (IBAction)messagePartner:(id)sender {
}
@end
