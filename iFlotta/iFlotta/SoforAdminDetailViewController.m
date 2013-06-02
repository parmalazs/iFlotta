//
//  SoforAdminDetailViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "SoforAdminDetailViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SoforAdminDetailViewController (){
    UITextField* activeField;
    NSArray* labelElements;
}

@end

@implementation SoforAdminDetailViewController
@synthesize scrollView;

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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    
self.driverNameTextField.delegate = self;
self.driverAdressTextField.delegate = self;
self.driverEmailTextField.delegate = self;
self.driverTelTextField.delegate = self;
self.driverLoginTextField.delegate = self;
self.driverPasswordTextField.delegate = self;
//self.driverIsAdminTextField.delegate = self ;
self.driverBirthdateTextField.delegate = self;
    
    /*
     @dynamic soforBirthDate;
     @dynamic soforCim;
     @dynamic soforEmail;
     @dynamic soforID;
     @dynamic soforIsAdmin;
     @dynamic soforLogin;
     @dynamic soforNev;
     @dynamic soforPass;
     @dynamic soforProfilKepId;
     @dynamic soforRegTime;
     @dynamic soforTelefonszam;
     @dynamic soforIsActive;
     @dynamic autoRelationship;
     @dynamic munka;
     @dynamic profilkep;*/
    
    self.driverNameLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.driverNameLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.driverNameTextField.text = [self.siteData valueForKey:@"soforNev"];
    
    self.driverAdressLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.driverAdressLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.driverAdressTextField.text = [self.siteData valueForKey:@"soforCim"];
    
    self.driverEmailLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.driverEmailLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.driverEmailTextField.text = [self.siteData valueForKey:@"soforEmail"];
    
    self.driverTelLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.driverTelLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.driverTelTextField.text = [self.siteData valueForKey:@"soforTelefonszam"];
    
    self.driverLoginLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.driverLoginLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.driverLoginTextField.text = [self.siteData valueForKey:@"soforLogin"];
    
    self.driverPasswordLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.driverPasswordLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.driverPasswordTextField.text = [self.siteData valueForKey:@"soforPass"];
    
    self.driverIsAdminLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.driverIsAdminLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.driverBirthdateLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.driverBirthdateLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.driverBirthdateTextField.text = [self.siteData valueForKey:@"soforBirthDate"];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender {
   
    NSNumber *maxid = [DataBaseUtil fetchRequestMaxID:@"Sofor" :@"soforID"];
    
    int value = [maxid intValue];
    maxid = [NSNumber numberWithInt:value + 1];
    

    labelElements = [[NSArray alloc]
                     initWithObjects:
                     _driverNameTextField.text,
                     _driverAdressTextField.text,
                     _driverEmailTextField.text,
                     _driverTelTextField.text,
                     _driverWebTextField.text,
                     _driverXTextField.text,
                     _driverYTextField.text,
                     _driverLoginTextField.text,
                     _driverPasswordTextField.text,
                     _driverBirthdateTextField.text,
                     nil];
    
    
    if (![DataBaseUtil IsInsert:labelElements])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sofőr"
                                                        message:@"Kérem töltsön ki minden mezőt!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        [DataBaseUtil insertSofor:[[NSNumber alloc] initWithInt:[maxid intValue]] :_driverNameTextField.text  :_driverAdressTextField.text :_driverLoginTextField.text :_driverPasswordTextField.text :_driverTelTextField.text :@"DateNow" :_driverBirthdateTextField.text :_driverEmailTextField.text :[[NSNumber alloc] initWithInt:0] :[[NSNumber alloc] initWithInt:2] :[[NSNumber alloc] initWithInt:1]];
        
        NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Sofor" :@"soforID" :[maxid stringValue] ];
        
        [JsonUtil JsonBuilderSender:obj :@"Sofor" :@"insert"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Sofőr"
                                                        message:@"Új sofőr felvéve!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}

// Call this method somewhere in your view controller setup code.

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height+activeField.frame.size.height*2);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }

}

// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

//////////////////// idaig //////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end