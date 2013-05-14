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
#import "JobsViewController.h"
#import "SiteViewController.h"
#import "DriverViewController.h"
#import "PartnerViewController.h"



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
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.labelElements = [[NSArray alloc]
                          initWithObjects:@"Autók",
                          @"Munkák",
                          @"Kontaktok",
                          @"Telephelyek",
                          @"Térkép",
                          nil];
    
    self.ImageElements = [[NSArray alloc]
                          initWithObjects:@"autok.png",
                          @"autok.png",
                          @"kontaktok.png",
                          @"kontaktok.png",
                          @"kontaktok.png",
                          nil];
    
    
    
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
    
    UIImage *imageElement = [UIImage imageNamed:
                             [self.ImageElements objectAtIndex: [indexPath row]]];
    
    cell.imageElement.image = imageElement;
    
    cell.imageNavigate.image = [UIImage imageNamed: @"navigacio.png"];
    
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSString*mystring;
    mystring = [self.tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSLog(@"%@",mystring);
    
    switch (indexPath.row) {
        case 2:
        {
            ContactTabBarController *contactTabBarController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"contactTabBarController"];
            [self.navigationController pushViewController:contactTabBarController animated:YES];
        }
            break;
        case 0:
        {
            CarsViewController *carsViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"carsViewController"];
            [self.navigationController pushViewController:carsViewController animated:YES];
        }
            break;
        case 1:
        {
            JobsViewController *jobsViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"jobsViewController"];
            [self.navigationController pushViewController:jobsViewController animated:YES];
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
