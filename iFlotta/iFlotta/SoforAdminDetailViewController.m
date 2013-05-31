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
self.driverWebTextField.delegate = self;
self.driverXTextField.delegate = self;
self.driverYTextField.delegate = self;
self.driverLoginTextField.delegate = self;
self.driverPasswordTextField.delegate = self;
self.driverIsAdminTextField.delegate = self ;
self.driverBirthdateTextField.delegate = self;
    
    
    self.driverNameLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverNameLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.driverAdressLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverAdressLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.driverEmailLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverEmailLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.driverTelLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverTelLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.driverWebLabel.backgroundColor= UIColorFromRGB(0xD9B384);
    self.driverWebLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.driverXLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverXLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.driverYLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverYLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.driverLoginLabel.backgroundColor= UIColorFromRGB(0xD9B384);
    self.driverLoginLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.driverPasswordLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverPasswordLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.driverIsAdminLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverIsAdminLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    
    self.driverBirthdateLabel.backgroundColor = UIColorFromRGB(0xD9B384);
    self.driverBirthdateLabel.textColor  = UIColorFromRGB(0xFFFFFF);
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButton:(id)sender {
    /*@property (strong, nonatomic) IBOutlet UITextField *driverNameTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverAdressTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverEmailTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverTelTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverWebTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverXTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverYTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverLoginTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverPasswordTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverIsAdminTextField;
    @property (strong, nonatomic) IBOutlet UITextField *driverBirthdateTextField;
   
    +(void)insertSofor:(NSNumber*) soforID : (NSString*) soforNev : (NSString*) soforCim : (NSString*) soforLogin : (NSString*) soforPass : (NSString*) soforTelefonszam : (NSString*) soforRegTime : (NSString*) soforBirthDate : (NSString*) soforEmail : (NSNumber*) soforIsAdmin : (NSNumber*) soforProfilKepId : (NSNumber*) soforIsActive
    { */
    
    //+ (NSNumber*)fetchRequestMaxID:(NSString*) entityName : (NSString*) sortName {
    
    NSNumber *maxid = [DataBaseUtil fetchRequestMaxID:@"Sofor" :@"soforID"];
    
    int value = [maxid intValue];
    maxid = [NSNumber numberWithInt:value + 1];
    
    //NSLog(@"%@",maxid);
    
    [DataBaseUtil insertSofor:[[NSNumber alloc] initWithInt:[maxid intValue]] :_driverNameTextField.text  :@"iOSPista" :@"iOSPista" :@"iOSPista" :@"iOSPista" :@"iOSPista" :@"iOSPista" :@"iOSPista" :[[NSNumber alloc] initWithBool:YES] :[[NSNumber alloc] initWithInt:2] :[[NSNumber alloc] initWithBool:YES]];
    
    NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Sofor" :@"soforID" :[maxid stringValue] ];
    
    [JsonUtil JsonBuilderSender:obj :@"Sofor"];
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
