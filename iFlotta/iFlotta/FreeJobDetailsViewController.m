//
//  FreeJobDetailsViewController.m
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "FreeJobDetailsViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface FreeJobDetailsViewController ()

@end

@implementation FreeJobDetailsViewController

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
    
//    self.jobAttribute1.text = [self.driverData valueForKey:@"soforCim"];
    self.jobAttribute1.backgroundColor = UIColorFromRGB(0xD9B384);
    self.jobAttribute1.textColor = UIColorFromRGB(0x260B01);
//    self.jobAttribute2.text = [self.driverData valueForKey:@"soforNev"];
    self.jobAttribute2.backgroundColor = UIColorFromRGB(0xD9B384);
    self.jobAttribute2.textColor = UIColorFromRGB(0x260B01);
    
//    self.jobAttribute3.text = [self.driverData valueForKey:@"soforTelefonszam"];
    self.jobAttribute3.backgroundColor = UIColorFromRGB(0xD9B384);
    self.jobAttribute3.textColor = UIColorFromRGB(0x260B01);
//    self.jobAttribute4.text = [self.driverData valueForKey:@"soforEmail"];
    self.jobAttribute4.backgroundColor = UIColorFromRGB(0xD9B384);
    self.jobAttribute4.textColor = UIColorFromRGB(0x260B01);
    
    self.jobAttribute5.backgroundColor = UIColorFromRGB(0xD9B384);
    self.jobAttribute5.textColor = UIColorFromRGB(0x260B01);
    
    /// ezek a labelek
    self.nevLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.nevLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.telLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.telLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.emailLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.emailLabel.textColor       = UIColorFromRGB(0xFFFFFF);
    self.label4.backgroundColor = UIColorFromRGB(0x46594B);
    self.label4.textColor       = UIColorFromRGB(0xFFFFFF);
    self.label5.backgroundColor = UIColorFromRGB(0x46594B);
    self.label5.textColor       = UIColorFromRGB(0xFFFFFF);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)felveszButton:(id)sender {
    [DataBaseUtil munkaFelvesz:[[_freeJobData valueForKey:@"munkaID"] stringValue]];
    
    
    NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Munka" :@"munkaID" :[[_freeJobData valueForKey:@"munkaID"] stringValue] ];
    
    NSLog(@"%@",[obj objectAtIndex:0]);
    
    [JsonUtil JsonBuilderSender:obj :@"Munka" :@"munkafevesz"];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Munka"
                                                    message:@"Az adott munkát felvette!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    [self.navigationController popViewControllerAnimated: YES];
}
@end
