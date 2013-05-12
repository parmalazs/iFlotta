//
//  SiteDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/12/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "SiteDetailsViewController.h"

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
    
    self.siteName.text = [self.siteData valueForKey:@"telephelyNev"];
    self.siteAddress.text = [self.siteData valueForKey:@"telephelyCim"];
    self.sitePhone.text = [self.siteData valueForKey:@"telephelyTelefonszam"];
    self.siteMail.text = [self.siteData valueForKey:@"telephelyEmail"];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
