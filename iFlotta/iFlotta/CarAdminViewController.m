//
//  CarAdminViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "CarAdminViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface CarAdminViewController (){
    UITextField* activeField;
}

@end
@implementation CarAdminViewController
{
    NSArray  * labelElements;
}
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
    
    self.carNameTextField.delegate=self;
    self.carTypeTextField.delegate=self;
    self.carSpeedometerTextField.delegate = self;
    self.carFuelTextField.delegate=self;
    self.carRendszamTextField.delegate=self;
    self.carMuszakiTextField.delegate=self;
    self.carServiceTextField.delegate=self;
    self.carXTextField.delegate=self;
    self.carYTextField.delegate=self;
    
    /*
     @dynamic autoFoglalt;
     @dynamic autoID;
     @dynamic autoKilometerOra;
     @dynamic autoLastSoforID;
     @dynamic autoLastSzervizDate;
     @dynamic autoLastTelephelyID;
     @dynamic autoLastUpDate;
     @dynamic autoMuszakiVizsgaDate;
     @dynamic autoNev;
     @dynamic autoProfilKepID;
     @dynamic autoRendszam;
     @dynamic autoTipus;
     @dynamic autoUzemAnyag;
     @dynamic autoXkoordinata;
     @dynamic autoYkoordinata;
     @dynamic autoIsActive;
     @dynamic autokep;
     @dynamic sofor;
     @dynamic telephely;
     */
    [self registerForKeyboardNotifications];
	 self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    
    self.carNameLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.carNameLabel.textColor= UIColorFromRGB(0xFFFFFF);
    self.carNameTextField.text = [self.adatDetails valueForKey:@"autoNev"];
    
    self.carTypeLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carTypeLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carTypeTextField.text = [self.adatDetails valueForKey:@"autoTipus"];

    self.carSpeedometerLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carSpeedometerLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carSpeedometerTextField.text = [self.adatDetails valueForKey:@"autoKilometerOra"];
    
    self.carRendszamLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carRendszamLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carRendszamTextField.text = [self.adatDetails valueForKey:@"autoRendszam"];
    
    self.carMuszakiLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carMuszakiLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carMuszakiTextField.text = [self.adatDetails valueForKey:@"autoMuszakiVizsgaDate"];
    
    self.carServiceLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carServiceLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carServiceTextField.text = [self.adatDetails valueForKey:@"autoSzervizDate"];
    
    self.carXLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carXLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carXTextField.text = [self.adatDetails valueForKey:@"autoXkoordinata"];
   
    self.carYLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carYLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carYTextField.text = [self.adatDetails valueForKey:@"autoYkoordinata"];
    
    self.carFuelLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.carFuelLabel.textColor = UIColorFromRGB(0xFFFFFF);
    self.carFuelTextField.text = [self.adatDetails valueForKey:@"autoUzemanyag"];
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePicture:(id)sender {
    
}

- (IBAction)saveButton:(id)sender {
    
    NSNumber *maxid = [DataBaseUtil fetchRequestMaxID:@"Auto" :@"autoID"];
    
    int value = [maxid intValue];
    maxid = [NSNumber numberWithInt:value + 1];
    NSLog(@"%@",maxid);
    
    labelElements = [[NSArray alloc]
                          initWithObjects:_carNameTextField.text,
                          _carTypeTextField.text,
                          _carSpeedometerTextField.text,
                          _carFuelTextField.text,
                          _carRendszamTextField.text,
                          _carMuszakiTextField.text,
                          _carServiceTextField.text,
                          _carXTextField.text,
                          _carYTextField.text,
                          nil];
    
    
    if (![DataBaseUtil IsInsert:labelElements])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Jármű"
                                                        message:@"Kérem adjon meg minden mezőt!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        [DataBaseUtil insertAuto:[[NSNumber alloc] initWithInt:[maxid intValue]] :_carNameTextField.text :_carRendszamTextField.text :_carTypeTextField.text :_carServiceTextField.text :_carServiceTextField.text :_carMuszakiTextField.text :[[NSNumber alloc] initWithInt:[[_carSpeedometerTextField text] intValue]] :[[NSNumber alloc] initWithInt:11] :[[NSNumber alloc] initWithInt:[[_carFuelTextField text] intValue] ] :[[NSNumber alloc] initWithDouble:[[_carXTextField text] doubleValue] ] :[[NSNumber alloc] initWithDouble:[[_carXTextField text] doubleValue]] :[[NSNumber alloc] initWithInt:2]];
        
        NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Auto" :@"autoID" :[maxid stringValue] ];
        
        NSLog(@"%@",[obj objectAtIndex:0]);
        
        [JsonUtil JsonBuilderSender:obj :@"Auto" :@"insert"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Jármű"
                                                        message:@"Új jármű felvéve!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
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

@end
