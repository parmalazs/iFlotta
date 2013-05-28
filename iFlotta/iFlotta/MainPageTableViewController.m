//
//  MainPageTableViewController.m
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "MainPageTableViewController.h"
#import "MainTableViewCell.h"
#import "CarsViewController.h"
#import "ContactTabBarController.h"
#import "SiteViewController.h"
#import "DriverViewController.h"
#import "PartnerViewController.h"
#import "JobsTabBarController.h"
#import "DataBaseUtil.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface MainPageTableViewController ()

@end

@implementation MainPageTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
    // Admin ellenőrzés
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUser] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    
    
    self.labelElements = [[NSArray alloc]
                          initWithObjects:@"Járművek",
                          @"Munkák",
                          @"Kontaktok",
                          @"Telephelyek",
                          @"Térkép",
                          nil];
    
    self.ImageElements = [[NSArray alloc]
                          initWithObjects:@"car146x120.png",
                          @"jobs146x120.png",
                          @"partnerek146x120.png",
                          @"telephelyek146x120.png",
                          @"terkep146x120.png",
                          nil];
    
    [self.navigationController.navigationBar setTintColor:UIColorFromRGB(0x46594B)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.labelElements count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"mainTableViewCell";
    
    MainTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MainTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.labelElement.text = [self.labelElements
                              objectAtIndex: [indexPath row]];
    cell.labelElement.textColor = UIColorFromRGB(0xD9B384);
    cell.labelElement.backgroundColor = UIColorFromRGB(0x260B01);
    
    
    UIImage *imageElement = [UIImage imageNamed:
                             [self.ImageElements objectAtIndex: [indexPath row]]];
    
    cell.imageElement.image = imageElement;
    //cell.imageElement.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"gomb_1a_146x120.png"]];
    //cell.imageElement.backgroundColor = UIColorFromRGB(0x260B01);
    //cell.imageNavigate.image = [UIImage imageNamed: @"navigacio.png"];
    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 2:
        {
            ContactTabBarController *contactTabBarController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"contactTabBarController"];
            [self.navigationController pushViewController:contactTabBarController animated:YES];
        }
            break;
        case 0:
        {
            CarsViewController *carsViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"jarmuTabBarController"];
            [self.navigationController pushViewController:carsViewController animated:YES];
        }
            break;
        case 1:
        {
            JobsTabBarController *jobsTabBarController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"jobsTabBarController"];
            [self.navigationController pushViewController:jobsTabBarController animated:YES];
        }
            break;
        case 3:
        {
            SiteViewController *siteViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"initViewController"];
            [self.navigationController pushViewController:siteViewController animated:YES];
        }
            break;
        case 4:
        {
            // Térkép
        }
            break;
            
    }
    
    
}
@end
