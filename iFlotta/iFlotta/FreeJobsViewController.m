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
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface FreeJobsViewController (){
    BOOL _isAdmin;
}

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
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    [freeJobsSearchBar setShowsScopeBar:NO];
    [freeJobsSearchBar sizeToFit];
    [freeJobsSearchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + freeJobsSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
    }
    else
    {
        _isAdmin = YES;
    }
    
    
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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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
    
    if ([indexPath row] % 2) {
        cell.contentView.backgroundColor = UIColorFromRGB(0xA6977C);
    }else{
        cell.contentView.backgroundColor = UIColorFromRGB(0xD9B384);
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
    if (_isAdmin) {
        [self performSegueWithIdentifier:@"freeJobAdminDetails" sender:tableView];
    }else{
        [self performSegueWithIdentifier:@"freeJobDetails" sender:tableView];
    }
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


- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredFreeJobsArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.munkaDate contains[c] %@) or (SELF.munkaComment contains[c] %@) or (SELF.munkaBefejezesDate contains[c] %@)",searchText,searchText,searchText,searchText];
    NSArray *tempArray = [self.freeJobsArray filteredArrayUsingPredicate:predicate];
    
    if([scope isEqualToString:@"Dátum"])
    {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"(SELF.munkaDate contains[c] %@)",searchText];
        tempArray = [self.freeJobsArray filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Komment"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.munkaComment contains[c] %@",searchText];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Befejezés"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.munkaBefejezesDate contains[c] %@",searchText];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    filteredFreeJobsArray = [NSMutableArray arrayWithArray:tempArray];
    //NSLog(@"Array: %d", filteredSiteArray.count);
}


#pragma mark - UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


-(void)rendezKoltseg
{
    self.freeJobsArray = [DataBaseUtil fetchRequestSzabadMunka:@"Munka" :@"1" :@"munkaIsActive" :@"0" :@"munkaKoltseg" :[NSNumber numberWithInt:1]];    
    [[self tableView] reloadData];
}

-(void)rendezDatum
{
    self.freeJobsArray = [DataBaseUtil fetchRequestSzabadMunka:@"Munka" :@"1" :@"munkaIsActive" :@"0" :@"munkaDate" :[NSNumber numberWithInt:1]];
    [[self tableView] reloadData];
}

-(void)frissit
{
    self.freeJobsArray = [DataBaseUtil fetchRequest:@"Munka" :@"1" :@"munkaIsActive"];
    filteredFreeJobsArray = [NSMutableArray arrayWithCapacity:[self.freeJobsArray count]];
    [[self tableView] reloadData];
}
@end
