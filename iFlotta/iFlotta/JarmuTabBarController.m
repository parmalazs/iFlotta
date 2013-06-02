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
    
    BOOL _vanautom;
    CarsViewController *autovc;
    BuszViewController *buszvc;
    KamionViewController *kamionvc;
    TeherautoViewController *teherautovc;
    KisteherautoViewController *kisteherautovc;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)friss
{
    autovc.frissit;
    buszvc.frissit;
    kamionvc.frissit;
    teherautovc.frissit;
    kisteherautovc.frissit;
    
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        
        if ([DataBaseUtil autoFoglal:@"kamambert"])
        {
            _vanautom=YES;
            dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Járművem",@"image":@"image"},@{@"name" : @"Jármű leadás",@"image":@"image"},@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:4]];
        }
        else
        {
            dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:2]];
        }
        
        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új jármű felévete",@"image" : @"image"},@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:3]];
    }
    self.navigationItem.rightBarButtonItem = dropdownSorted.barButton;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray * vc = [self viewControllers];
    autovc = [vc objectAtIndex:0];
    buszvc = [vc objectAtIndex:1];
    kamionvc = [vc objectAtIndex:2];
    teherautovc = [vc objectAtIndex:3];
    kisteherautovc = [vc objectAtIndex:4];
    
    autovc.frissit;
    buszvc.frissit;
    kamionvc.frissit;
    teherautovc.frissit;
    kisteherautovc.frissit;
    
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        
        if ([DataBaseUtil autoFoglal:@"kamambert"])
        {
            _vanautom=YES;
            dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Járművem",@"image":@"image"},@{@"name" : @"Jármű leadás",@"image":@"image"},@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:4]];
        }
        else
        {
            dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:2]];
        }
        
        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új jármű felévete",@"image" : @"image"},@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:3]];
    }
    self.navigationItem.rightBarButtonItem = dropdownSorted.barButton;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _vanautom=NO;
    self.delegate = self;

    /*
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        if ([DataBaseUtil autoFoglal:@"kamambert"])
        {
            _vanautom=YES;
            dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Járművem",@"image":@"image"},@{@"name" : @"Jármű leadás",@"image":@"image"},@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:4]];
        }
        else
        {
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:2]];
        }

        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új jármű felévete",@"image" : @"image"},@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Rendszám szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:3]];
    }
    
    
    self.navigationItem.rightBarButtonItem = dropdownSorted.barButton;

    */
    
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
            case 1:
            {
                NSLog(@"1");
                
                if ([DataBaseUtil autoFoglal:[DataBaseUtil  foglaltAutoID]])
                {
                    NSLog(@"Leadjuk");
                    [DataBaseUtil autoFoglal:[DataBaseUtil foglaltAutoID] : [NSNumber numberWithInt:0] ];
                    
                    NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Auto" :@"autoID" :[DataBaseUtil foglaltAutoID] ];
                    
                    //NSLog(@"%@",[obj objectAtIndex:0]);
                    
                    [JsonUtil JsonBuilderSender:obj :@"Auto" :@"update"];
                    
                    //[self.navigationController popViewControllerAnimated: YES];
                    
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
                    [dropdownSorted dismiss];
                    
                    [self friss];
                    
                }
                else
                {
                    //NSLog(@"Nincs autód, vegyél fel vmt!");
                    autovc.rendezRendszam;
                    buszvc.rendezRendszam;
                    kamionvc.rendezRendszam;
                    teherautovc.rendezRendszam;
                    kisteherautovc.rendezRendszam;
                }
                
            }
                break;
            case 0:
            {
                if ([DataBaseUtil autoFoglal:@"kamambert"])
                {
                    NSLog(@"JÁRMŰ MEGTEKINTÉSE");
                }
                else
                {
                    autovc.rendezNev;
                    buszvc.rendezNev;
                    kamionvc.rendezNev;
                    teherautovc.rendezNev;
                    kisteherautovc.rendezNev;
                    //[dropdownSorted dismiss];
                }
            }
                break;
            case 2:
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
