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
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface ContactTabBarController ()

@end

@implementation ContactTabBarController
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
    // Admin ellenőrzés
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUser] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Név szerint rendezés",@"image":@"166-newspaper.png"},@{@"name":@"Cim szerint rendezés",@"image":@"280-clapboard.png"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új sofőr felvétel",@"image" : @"40-inbox.png"},@{@"name" : @"Új partner felvétel",@"image" : @"40-inbox.png"},@{@"name" : @"Név szerint rendezés",@"image":@"166-newspaper.png"},@{@"name":@"Cim szerint rendezés",@"image":@"280-clapboard.png"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
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
    NSArray * vc = [self viewControllers];
    PartnerViewController *pvc = [vc objectAtIndex:1];
    DriverViewController *dvc = [vc objectAtIndex:0];
    if (_isAdmin)
    {
        switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
            case 0:
                NSLog(@"0");
                break;
            case 1:
                NSLog(@"1");
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

@end
