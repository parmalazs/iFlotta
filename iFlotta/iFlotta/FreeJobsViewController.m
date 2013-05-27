//
//  FreeJobsViewController.m
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "FreeJobsViewController.h"
#import "DataBaseUtil.h"
#import "Munka.h"
#import "FreeJobsTableViewCell.h"
#import "FreeJobDetailsViewController.h"


@interface FreeJobsViewController ()

@end

@implementation FreeJobsViewController
@synthesize freeJobsSearchBar;
@synthesize filteredFreeJobsArray;

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
    
    [freeJobsSearchBar sizeToFit];
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + freeJobsSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    self.freeJobsArray = [DataBaseUtil fetchRequest:@"Munka" :@"1" :@"munkaIsActive"];
    
    
    filteredFreeJobsArray = [NSMutableArray arrayWithCapacity:[self.freeJobsArray count]];
    [[self tableView] reloadData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredFreeJobsArray count];
    }
	else
	{
        return [self.freeJobsArray count];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"freeJobsTableViewCell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    Munka *job= nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        job = [filteredFreeJobsArray objectAtIndex:[indexPath row]];
        
        [[cell textLabel] setText:[job munkaDate]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
	else
	{
        job = [self.freeJobsArray objectAtIndex:[indexPath row]];
        [[(FreeJobsTableViewCell*)cell jobLabel] setText:[job munkaDate]];
    }
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"freeJobDetails" sender:tableView];
    //[self.navigationController pushViewController:siteDetailsViewController animated:YES];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"freeJobDetails"] ) {
        FreeJobDetailsViewController *freeJobDetailsViewController = [segue destinationViewController];
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            freeJobDetailsViewController.freeJobData = [filteredFreeJobsArray objectAtIndex: [indexPath row]];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            freeJobDetailsViewController.freeJobData = [self.freeJobsArray objectAtIndex: [indexPath row]];
        }
        
    }
}

@end
