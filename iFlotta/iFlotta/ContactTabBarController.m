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
#import "SearchViewController.h"

@interface ContactTabBarController ()

@end

@implementation ContactTabBarController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButton:(id)sender {
    
    SearchViewController *searchViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"searchViewController"];
    [self.navigationController pushViewController:searchViewController animated:YES];
}
@end
