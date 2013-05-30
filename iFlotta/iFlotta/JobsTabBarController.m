//
//  JobsTabBarController.m
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "JobsTabBarController.h"
#import "FreeJobsViewController.h"
#import "OwnJobsViewController.h"
#import "DataBaseUtil.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface JobsTabBarController ()

@end

@implementation JobsTabBarController
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
	// Do any additional setup after loading the view.
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUser] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Név szerint rendezés",@"image":@"166-newspaper.png"},@{@"name":@"Dátum szerint rendezés",@"image":@"280-clapboard.png"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új munka felévete",@"image" : @"40-inbox.png"},@{@"name" : @"Név szerint rendezés",@"image":@"166-newspaper.png"},@{@"name":@"Dátum szerint rendezés",@"image":@"280-clapboard.png"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:5]];
    }
    self.navigationItem.rightBarButtonItem = dropdownSorted.barButton;
    
    
    [self.searchDisplayController.searchBar setTintColor:UIColorFromRGB(0x260B01)];
    [self.searchDisplayController.searchBar setShowsScopeBar:NO];
}

-(void)setViewControllers:(NSArray *)viewControllers animated:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)didSelectItem:(NSDictionary *)item{
    NSLog(@"%@",item);
    NSArray * vc = [self viewControllers];
    FreeJobsViewController *freevc = [vc objectAtIndex:0];
    OwnJobsViewController *ownvc = [vc objectAtIndex:1];
    
    if (_isAdmin)
    {
        switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
            case 0:
                NSLog(@"0");
                
                break;
            case 1:
            {
                NSLog(@"1");
                freevc.rendezKoltseg;
                //ownvc.rendezNev;
            }
                break;
            default:
            {
                NSLog(@"6");
                freevc.rendezDatum;
                //ownvc.rendezDatum;
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
                freevc.rendezKoltseg;
                //ownvc.rendezNev;
            }
                break;
            default:
            {
                NSLog(@"1");
                freevc.rendezDatum;
                //ownvc.rendezDatum;
            }
                break;
        }    }
    
    [dropdownSorted dismiss];
}

@end
