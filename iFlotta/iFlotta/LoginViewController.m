//
//  LoginViewController.m
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "Sofor.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"
#import "MainPageNavigationViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface LoginViewController (){
    NSArray* _imgPicsArray;
    int idx;
    UITextField* activeField;
}
@end

@implementation LoginViewController
@synthesize pic1;
@synthesize pic2;
@synthesize pic3;
@synthesize pic4;
@synthesize loginButton;
@synthesize userName;
@synthesize userNameLabel;
@synthesize userPassword;
@synthesize userPasswordLabel;
@synthesize scrollView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDatabase];
    
    userName.delegate=self;
    userPassword.delegate=self;
    [self registerForKeyboardNotifications];
   // loginButton.hidden = true;
    loginButton.alpha = 0.0;
    //loginButton.backgroundColor
    userName.alpha = 0.0;
    userNameLabel.alpha = 0.0;
    userPassword.alpha = 0.0;
    userPasswordLabel.alpha = 0.0;
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    idx = 0;
    _imgPicsArray = [NSArray arrayWithObjects:@"auto-ikon.png", @"telephely-ikon.png", @"partnerek_ikon.png", @"munka-ikon2.png", nil];
    for (int i = 0; i < _imgPicsArray.count; i++) {
        [NSTimer scheduledTimerWithTimeInterval:(i+1)*0.6 target:self selector:@selector(addPic:) userInfo:nil repeats:NO];
    }
    
    [NSTimer scheduledTimerWithTimeInterval:3.5 target:self selector:@selector(changeToLogin) userInfo:nil repeats:NO];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Login
- (IBAction)userLoginButton:(id)sender {
    
    NSArray *fetchedObjects = [DataBaseUtil fetchRequest:@"Sofor" :@"1" :@"soforIsActive"];
    
    for (NSManagedObject *aktsofor in fetchedObjects) {
        NSString* tmpLogin = [aktsofor valueForKey:@"soforLogin"];
        NSString* tmpPassword = [aktsofor valueForKey:@"soforPass"];
        if ([tmpLogin isEqualToString:self.userName.text] && [tmpPassword isEqualToString:self.userPassword.text] )
        {
            MainPageNavigationViewController *mainPage = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MainPageStoryboardID"];
            [DataBaseUtil setUser:[aktsofor valueForKey:@"soforIsAdmin"] :[aktsofor valueForKey:@"soforID"] :@"0" ];
            
        [self presentViewController:mainPage animated:YES completion:^{
            
        }];
        }

    }
}

-(void)changeToLogin{
    
    // ikonok eltunnek
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         pic1.alpha = 0.0;
                     } 
                     completion:^(BOOL finished){
                         
                     }];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         pic2.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         pic3.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         pic4.alpha = 0.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
//    pic1.hidden = true;
//    pic2.hidden = true;
//    pic3.hidden = true;
//    pic4.hidden = true;
    
    // login view megjelenik:
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         loginButton.alpha = 1.0;
                     }
                     completion:^(BOOL finished){

                     }];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         userName.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         userNameLabel.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         userPassword.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    [UIView animateWithDuration:0.5
                          delay:1.0
                        options: (UIViewAnimationOptions)UIViewAnimationCurveEaseOut
                     animations:^{
                         userPasswordLabel.alpha = 1.0;
                     }
                     completion:^(BOOL finished){
                         
                     }];
    
//    loginButton.hidden = false;
//    userName.hidden = false;
//    userNameLabel.hidden =false;
//    userPassword.hidden = false;
//    userPasswordLabel.hidden = false;

}

-(void)addPic:(id)sender{
    switch (idx) {
        case 0:
            pic1 = [[UIImageView alloc] initWithFrame:CGRectMake(22.5+70*idx, 550/3+5 , 60, 60)];
            pic1.image = [UIImage imageNamed:[_imgPicsArray objectAtIndex:idx]];
            
            [self.view addSubview:pic1];
            break;
        case 1:
            pic2 = [[UIImageView alloc] initWithFrame:CGRectMake(22.5+70*idx, 550/3+5 , 60, 60)];
            pic2.image = [UIImage imageNamed:[_imgPicsArray objectAtIndex:idx]];
            [self.view addSubview:pic2];
            
            break;
        case 2:
            pic3 = [[UIImageView alloc] initWithFrame:CGRectMake(22.5+70*idx, 550/3+5, 60, 60)];
            pic3.image = [UIImage imageNamed:[_imgPicsArray objectAtIndex:idx]];
            [self.view addSubview:pic3];
            
            break;
        case 3:
            pic4 = [[UIImageView alloc] initWithFrame:CGRectMake(22.5+70*idx, 550/3+5, 60, 60)];
            pic4.image = [UIImage imageNamed:[_imgPicsArray objectAtIndex:idx]];
            [self.view addSubview:pic4];
            
            break;
        default:
            break;
    }
    idx++;
}

- (void)initDatabase
{
    [DataBaseUtil fillSoforTable];
    [DataBaseUtil fillTelephelyTable];
    [DataBaseUtil fillAutoTable];
    [DataBaseUtil fillPartnerTable];
    [DataBaseUtil fillMunkaTable];
    [DataBaseUtil fillMunkatipusTable];
    [DataBaseUtil fillAutokepTable];
    [DataBaseUtil fillProfilkepTable];
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


@end
