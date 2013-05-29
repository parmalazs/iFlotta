//
//  AdminViewController.m
//  iFlott
//
//  Created by Csüti on 5/14/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "AdminViewController.h"
#import "CarAddViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface AdminViewController ()

@end

@implementation AdminViewController

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
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View1"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View2"]];
	[self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View3"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View4"]];
    [self addChildViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"View5"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)carAddViewControllerDidCancel:(CarAddViewController *)controller
{
	[self dismissViewControllerAnimated:YES completion:nil];
}

-(void)carAddViewController:(CarAddViewController *)controller didAddCar:(NSString *)car
{
	//[self.cars addObject:car];
    NSLog(@"Auto: %@",car);
    // NSLog
	[self dismissViewControllerAnimated:YES completion:nil];
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:@"AddCar"])
	{
		UINavigationController *navigationController = segue.destinationViewController;
		CarAddViewController *carAddViewController = [[navigationController viewControllers] objectAtIndex:0];
		carAddViewController.delegate = self;
        // itt el kell menteni az aktuális page-et ami a pagecontrolban van!
	}
}

@end
