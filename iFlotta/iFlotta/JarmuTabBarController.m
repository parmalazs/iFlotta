//
//  JarmuTabBarController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "JarmuTabBarController.h"
#import "VehiclesDetailsViewController.h"
#import "CarsViewController.h"
#import "BuszViewController.h"
#import "KamionViewController.h"
#import "KisteherautoViewController.h"
#import "TeherautoViewController.h"
#import "DataBaseUtil.h"
#import "CarAdminViewController.h"
#import "JsonUtil.h"



#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface JarmuTabBarController ()

@end

@implementation JarmuTabBarController
{
    BOOL _isAdmin;
}
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

    self.delegate = self;

    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Jármű leadás",@"image":@"166-newspaper.png"},@{@"name" : @"Név szerint rendezés",@"image":@"166-newspaper.png"},@{@"name":@"Rendszám szerint rendezés",@"image":@"280-clapboard.png"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új jármű felévete",@"image" : @"40-inbox.png"},@{@"name" : @"Név szerint rendezés",@"image":@"166-newspaper.png"},@{@"name":@"Rendszám szerint rendezés",@"image":@"280-clapboard.png"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
    }
    self.navigationItem.rightBarButtonItem = dropdownSorted.barButton;

    
    
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
}

-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender{
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didSelectItem:(NSDictionary *)item{
    NSLog(@"%@",item);
    NSArray * vc = [self viewControllers];
    CarsViewController *autovc = [vc objectAtIndex:0];
    BuszViewController *buszvc = [vc objectAtIndex:1];
    KamionViewController *kamionvc = [vc objectAtIndex:2];
    TeherautoViewController *teherautovc = [vc objectAtIndex:3];
    KisteherautoViewController *kisteherautovc = [vc objectAtIndex:4];
    
    if (_isAdmin)
    {
        switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
            case 0:
            {
                NSLog(@"0");
                CarAdminViewController *carAdminViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"carAdminViewController"];
                [self.navigationController pushViewController:carAdminViewController animated:YES];
            }
                break;
            case 1:
            {
                NSLog(@"2");
                autovc.rendezNev;
                buszvc.rendezNev;
                kamionvc.rendezNev;
                teherautovc.rendezNev;
                kisteherautovc.rendezNev;
            }
                break;
            default:
            {
                NSLog(@"3");
                autovc.rendezRendszam;
                buszvc.rendezRendszam;
                kamionvc.rendezRendszam;
                teherautovc.rendezRendszam;
                kisteherautovc.rendezRendszam;
            }
                break;
        }
    }
    else
    {
        switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
            case 0:
            {
                NSLog(@"0");
                if ([DataBaseUtil autoFoglal:[DataBaseUtil  foglaltAutoID]])
                {
                    NSLog(@"Leadjuk");
                    [DataBaseUtil autoFoglal:[DataBaseUtil foglaltAutoID] : [NSNumber numberWithInt:0] ];
                    
                    NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Auto" :@"autoID" :[DataBaseUtil foglaltAutoID] ];
                    
                    //NSLog(@"%@",[obj objectAtIndex:0]);
                    
                    [JsonUtil JsonBuilderSender:obj :@"Auto" :@"update"];
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Jármű"
                                                                    message:@"A járművet sikeresen leadta!"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                    
                    
                    autovc.frissit;
                    buszvc.frissit;
                    kamionvc.frissit;
                    teherautovc.frissit;
                    kisteherautovc.frissit;
                }
                else
                {
                    NSLog(@"Nincs autód, vegyél fel vmt!");
                }
            }
                break;
            case 1:
            {
                NSLog(@"1");
                autovc.rendezNev;
                buszvc.rendezNev;
                kamionvc.rendezNev;
                teherautovc.rendezNev;
                kisteherautovc.rendezNev;
            }
                break;
            default:
            {
                NSLog(@"2");
                autovc.rendezRendszam;
                buszvc.rendezRendszam;
                kamionvc.rendezRendszam;
                teherautovc.rendezRendszam;
                kisteherautovc.rendezRendszam;
            }
                break;
        }
    }
    
    [dropdownSorted dismiss];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    
    NSArray *tabViewControllers = tabBarController.viewControllers;
    UIView * fromView = tabBarController.selectedViewController.view;
    UIView * toView = viewController.view;
    if (fromView == toView)
        return true;
    NSUInteger fromIndex = [tabViewControllers indexOfObject:tabBarController.selectedViewController];
    NSUInteger toIndex = [tabViewControllers indexOfObject:viewController];
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.6
                       options: toIndex > fromIndex ? UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight
                    completion:^(BOOL finished) {
                        if (finished) {
                            tabBarController.selectedIndex = toIndex;
                        }
                    }];
    
    return true;
}

@end
