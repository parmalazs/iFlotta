//
//  ContactTabBarController.m
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "ContactTabBarController.h"
#import "DriverViewController.h"
#import "PartnerViewController.h"
#import "DataBaseUtil.h"
#import "SoforAdminDetailViewController.h"
#import "ContactsAdminViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ContactTabBarController ()

@end

@implementation ContactTabBarController
{
    BOOL _isAdmin;
    PartnerViewController *pvc;
    DriverViewController *dvc;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    NSArray * vc = [self viewControllers];
    pvc = [vc objectAtIndex:1];
    dvc = [vc objectAtIndex:0];
    pvc.frissit;
    dvc.frissit;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    
    // Admin ellenőrzés
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Cim szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új sofőr felvétel",@"image" : @"image"},@{@"name" : @"Új partner felvétel",@"image" : @"image"},@{@"name" : @"Név szerint rendezés",@"image":@"image"},@{@"name":@"Cim szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
    }
    self.navigationItem.rightBarButtonItem = dropdownSorted.barButton;
    
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didSelectItem:(NSDictionary *)item{
    NSLog(@"%@",item);
    /*
    NSArray * vc = [self viewControllers];
    PartnerViewController *pvc = [vc objectAtIndex:1];
    DriverViewController *dvc = [vc objectAtIndex:0];*/
    
    if (_isAdmin)
    {
        switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
            case 0:
            {
                SoforAdminDetailViewController *soforAdminDetailViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"soforAdminDetailViewController"];
                [self.navigationController pushViewController:soforAdminDetailViewController animated:YES];
            }
                break;
            case 1:
            {
                ContactsAdminViewController *contactsAdminViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"contactsAdminViewController"];
                [self.navigationController pushViewController:contactsAdminViewController animated:YES];            }
                break;
            case 2:
            {
                NSLog(@"2");
                pvc.rendezNev;
                dvc.rendezNev;
            }
                break;
            default:
            {
                NSLog(@"3");
                pvc.rendezCim;
                dvc.rendezCim;
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
                pvc.rendezNev;
                dvc.rendezNev;
            }
                break;
            default:
            {
                NSLog(@"1");
                pvc.rendezCim;
                dvc.rendezCim;
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
