//
//  ContactsAdminViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "ContactsAdminViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ContactsAdminViewController (){
    UITextField *activeField;
    NSArray* labelElements;
}

@end

@implementation ContactsAdminViewController
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
	self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    
    /*
     @dynamic partnerCim;
     @dynamic partnerEmailcim;
     @dynamic partnerID;
     @dynamic partnerNev;
     @dynamic partnerTelefonszam;
     @dynamic partnerWeboldal;
     @dynamic partnerXkoordinata;
     @dynamic partnerYkoordinata;
     @dynamic partnerIsActive;
     @dynamic munka;
     @dynamic partnerkepek;
     */
    
    self.contactsNameLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsNameLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.contactsNameTextField.text = [self.siteData valueForKey:@"partnerNev"];
    
    self.contactsAdressLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsAdressLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.contactsAdressTextField.text = [self.siteData valueForKey:@"partnerCim"];
    
    self.contactsEmailLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsEmailLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.contactsEmailTextField.text = [self.siteData valueForKey:@"partnerEmailcim"];
    
    self.contactsTelLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsTelLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.contactsTelTextField.text = [self.siteData valueForKey:@"partnerTelefonszam"];
    
    self.contactsWebLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsWebLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.contactsWebTextField.text = [self.siteData valueForKey:@"partnerWeboldal"];
    
    self.contactsXLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsXLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.contactsXTextField.text = [[self.siteData valueForKey:@"partnerXkoordinata"] stringValue];
    
    self.contactsYLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.contactsYLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    self.contactsYTextField.text = [[self.siteData valueForKey:@"partnerYkoordinata"] stringValue];
    
    self.contactsNameTextField.delegate = self;
    self.contactsAdressTextField.delegate = self;
    self.contactsEmailTextField.delegate = self;
    self.contactsTelTextField.delegate = self;
    self.contactsWebTextField.delegate = self;
    self.contactsXTextField.delegate = self;
    self.contactsYTextField.delegate = self;
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///////////////////////////innentol copy //////////////////////////////////////////////////
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


- (IBAction)saveButtonPushed:(id)sender {
    
    NSNumber *maxid = [DataBaseUtil fetchRequestMaxID:@"Partner" :@"partnerID"];
    
    int value = [maxid intValue];
    maxid = [NSNumber numberWithInt:value + 1];
    
    labelElements = [[NSArray alloc]
                     initWithObjects:_contactsNameTextField.text,
                     _contactsAdressTextField.text,
                     _contactsEmailTextField.text,
                     _contactsTelTextField.text,
                     _contactsWebTextField.text,
                     _contactsXTextField.text,
                     _contactsYTextField.text,
                     nil];
    
    
    if (![DataBaseUtil IsInsert:labelElements])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Partner"
                                                        message:@"Kérem töltsön ki minden mezőt!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        if (self.siteData == nil)
        {
            [DataBaseUtil insertPartner:_contactsAdressTextField.text :_contactsEmailTextField.text :[[NSNumber alloc] initWithInt:[maxid intValue]] :_contactsNameTextField.text :_contactsWebTextField.text :_contactsTelTextField.text :[[NSNumber alloc] initWithDouble:[[_contactsXTextField text] doubleValue] ] :[[NSNumber alloc] initWithDouble:[[_contactsXTextField text] doubleValue] ] :[[NSNumber alloc] initWithInt:1]];
            
            NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Partner" :@"partnerID" :[maxid stringValue]];
            [JsonUtil JsonBuilderSender:obj :@"Partner" :@"insert"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Partner"
                                                            message:@"Új partner felvéve!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            [DataBaseUtil updatePartner:_contactsAdressTextField.text :_contactsEmailTextField.text :[[NSNumber alloc] initWithInt:[[self.siteData valueForKey:@"partnerID"] intValue]] :_contactsNameTextField.text :_contactsWebTextField.text :_contactsTelTextField.text :[[NSNumber alloc] initWithDouble:[[_contactsXTextField text] doubleValue] ] :[[NSNumber alloc] initWithDouble:[[_contactsXTextField text] doubleValue] ] :[[NSNumber alloc] initWithInt:1]];
            
            NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Partner" :@"partnerID" :[[self.siteData valueForKey:@"partnerID"] stringValue]];
            [JsonUtil JsonBuilderSender:obj :@"Partner" :@"update"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Partner"
                                                            message:@"Partner módositva!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}
@end
