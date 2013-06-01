//
//  SiteDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/12/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "SiteDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface SiteDetailsViewController ()

@end

@implementation SiteDetailsViewController

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
    
    self.siteName.text          = [self.siteData valueForKey:@"telephelyNev"];
    self.siteAddress.text       = [self.siteData valueForKey:@"telephelyCim"];
    self.sitePhone.text         = [self.siteData valueForKey:@"telephelyTelefonszam"];
    self.siteMail.text          = [self.siteData valueForKey:@"telephelyEmail"];
    
    
    self.siteAddress.backgroundColor    = UIColorFromRGB(0xD9B384);
    self.siteName.backgroundColor       = UIColorFromRGB(0x260B01);
    self.siteName.textColor             = UIColorFromRGB(0xD9B384);
    self.sitePhone.backgroundColor      = UIColorFromRGB(0xD9B384);
    self.siteMail.backgroundColor       = UIColorFromRGB(0xD9B384);
    
    /// ezek a labelek
    self.nevLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.nevLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.telLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.telLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.emailLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.emailLabel.textColor       = UIColorFromRGB(0xFFFFFF);
	// Do any additional setup after loading the view.
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?center=%f,%f&markers=%f,%f&%@&sensor=true",[[self.siteData valueForKey:@"telephelyXkoordinata"] floatValue], [[self.siteData valueForKey:@"telephelyYkoordinata"] floatValue],[[self.siteData valueForKey:@"telephelyXkoordinata"] floatValue], [[self.siteData valueForKey:@"telephelyYkoordinata"] floatValue],@"zoom=13&size=200x200"];
    NSLog(staticMapUrl);
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    self.mapImage.image = image;
    //self.mapImage
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
