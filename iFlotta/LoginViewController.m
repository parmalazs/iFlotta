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

    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // Az eddigi Sofor adatok törlése
    [DataBaseUtil deleteAllObjects:@"Sofor" :context ];
    
    // Json feldolgozása
    NSDictionary* jsonDictionary =[JsonUtil dictionaryWithContentsOfJSONURLString:@"http://www.flotta.host-ed.me/querySoforTable.php"];
    NSArray* rows = [jsonDictionary objectForKey:@"rows"]; 
    
    for (NSDictionary *result in rows) {
        //NSLog(@"Neve: %@", [result valueForKey:@"soforNev"]);
        Sofor* aktsofor = [NSEntityDescription
                        insertNewObjectForEntityForName:@"Sofor"
                        inManagedObjectContext:context];
        
        NSString* soforNev = [result valueForKey:@"soforNev"];
        [aktsofor setValue:soforNev forKey:@"soforNev"];
        
        NSString* soforLogin = [result valueForKey:@"soforLogin"];
        [aktsofor setValue:soforLogin forKey:@"soforLogin"];
        
        NSString* soforPass = [result valueForKey:@"soforPass"];
        [aktsofor setValue:soforPass forKey:@"soforPass"];
    }
    
    [DataBaseUtil saveContext:context];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Login
- (IBAction)userLoginButton:(id)sender {
    
    NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
    
    // query-re is egy általános fv-t irni a DataBaseUtil-ba
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription
                                   entityForName:@"Sofor" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError* error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
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
        else
        {
            // hibaüzenet feldobása
        }
    }
}

@end
