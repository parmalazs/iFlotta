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



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
            [DataBaseUtil setUser:[aktsofor valueForKey:@"soforIsAdmin"]];
            
            //NSLog(@"Admin-e: %@",[DataBaseUtil aktUser]);
            
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

@end
