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


@interface LoginViewController ()



@end

@implementation LoginViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Login
- (IBAction)userLoginButton:(id)sender {
    
    NSArray *fetchedObjects = [DataBaseUtil fetchRequest:@"Sofor" :@"1" :@"soforIsActive"];
    
    for (NSManagedObject *proba in fetchedObjects) {
        NSString* tmpLogin = [proba valueForKey:@"soforLogin"];
        NSString* tmpPassword = [proba valueForKey:@"soforPass"];
        if ([tmpLogin isEqualToString:self.userName.text] && [tmpPassword isEqualToString:self.userPassword.text] )
        {
            // ide majd a navigációt kell beilleszteni a következő page-re
            MainPageNavigationViewController *mainPage = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"MainPageStoryboardID"];
        
        [self presentViewController:mainPage animated:YES completion:^{
            
        }];
        }

    }
}

@end
