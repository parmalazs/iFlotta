//
//  AdminSiteViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "AdminSiteViewController.h"
#import "SiteDetailsViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AdminSiteViewController (){
    UITextField* activeField;
    NSArray* labelElements;
}

@end

@implementation AdminSiteViewController
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
    
    /*
     @dynamic telephelyCim;
     @dynamic telephelyEmail;
     @dynamic telephelyID;
     @dynamic telephelyNev;
     @dynamic telephelyTelefonszam;
     @dynamic telephelyXkoordinata;
     @dynamic telephelyYkoordinata;
     @dynamic telephelyIsActive;
     @dynamic autoRelationship;
     @dynamic munka;
     */
    
	// Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    [self registerForKeyboardNotifications];
    self.siteNevTextField.delegate = self;
    self.cimTextField.delegate = self;
    self.telTextField.delegate = self;
    self.emailTextField.delegate = self;
    self.xTextField.delegate = self;
    self.yTextField.delegate = self;
    
    self.siteNevTextField.text = [self.siteData valueForKey:@"telephelyNev"];
    self.cimTextField.text = [self.siteData valueForKey:@"telephelyCim"];
    self.telTextField.text = [self.siteData valueForKey:@"telephelyTelefonszam"];
    self.emailTextField.text = [self.siteData valueForKey:@"telephelyEmail"];
    self.xTextField.text = [[self.siteData valueForKey:@"telephelyXkoordinata"] stringValue];
    self.yTextField.text = [[self.siteData valueForKey:@"telephelyYkoordinata"] stringValue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
}

- (IBAction)makePhotoButtonPressed:(id)sender {
}///////////////////////////innentol copy //////////////////////////////////////////////////

- (IBAction)saveButton:(id)sender {
    NSNumber *maxid = [DataBaseUtil fetchRequestMaxID:@"Telephely" :@"telephelyID"];
    
    int value = [maxid intValue];
    maxid = [NSNumber numberWithInt:value + 1];
    
    labelElements = [[NSArray alloc]
                     initWithObjects:_siteNevTextField.text,
                     _cimTextField.text,
                     _telTextField.text,
                     _emailTextField.text,
                     _xTextField.text,
                     _yTextField.text,
                     nil];
    
    
    if (![DataBaseUtil IsInsert:labelElements])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Telephely"
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
            [DataBaseUtil insertTelephely:_cimTextField.text :_emailTextField.text :[[NSNumber alloc] initWithInt:[maxid intValue]] :_siteNevTextField.text : _telTextField.text :[[NSNumber alloc] initWithDouble:[[_xTextField text] doubleValue]] :[[NSNumber alloc] initWithDouble:[[_yTextField text] doubleValue]] :[[NSNumber alloc] initWithInt:1]];
            
            NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Telephely" :@"telephelyID" :[maxid stringValue]];
            [JsonUtil JsonBuilderSender:obj :@"Telephely" :@"insert"];
            
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Telephely"
                                                            message:@"Új telephely feléve!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            NSLog(@"%@",_siteNevTextField.text);
            NSLog(@"%@",[[self siteData] valueForKey:@"telephelyID"]);
            
            [DataBaseUtil updateTelephely:_cimTextField.text :_emailTextField.text :[[NSNumber alloc] initWithInt:[[self.siteData valueForKey:@"telephelyID"] intValue]] :_siteNevTextField.text : _telTextField.text :[[NSNumber alloc] initWithDouble:[[_xTextField text] doubleValue]] :[[NSNumber alloc] initWithDouble:[[_yTextField text] doubleValue]] :[[NSNumber alloc] initWithInt:1]];
            
            NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Telephely" :@"telephelyID" :[[self.siteData valueForKey:@"telephelyID"] stringValue]];
            [JsonUtil JsonBuilderSender:obj :@"Telephely" :@"update"];
            
            UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"Telephely"
                                                            message:@"Telephely módositva!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert2 show];
        }
        

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