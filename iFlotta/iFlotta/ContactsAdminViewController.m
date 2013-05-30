//
//  ContactsAdminViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "ContactsAdminViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ContactsAdminViewController ()

@end

@implementation ContactsAdminViewController

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
    
    self.contactsNameLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsNameLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.contactsAdressLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsAdressLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.contactsEmailLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsEmailLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.contactsTelLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsTelLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.contactsWebLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsWebLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.contactsXLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsXLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.contactsYLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsYLabel.textColor  = UIColorFromRGB(0xFFFFFF);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
