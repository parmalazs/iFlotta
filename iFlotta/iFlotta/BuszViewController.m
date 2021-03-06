//
//  BuszViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//
#import "CarAdminViewController.h"
#import "BuszViewController.h"
#import "DataBaseUtil.h"
#import "CarsTableViewCell.h"
#import "BuszCell.h"
#import "VehiclesDetailsViewController.h"
#import "Auto.h"
#import "CarAddViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface BuszViewController ()

@end

@implementation BuszViewController
{
    BOOL _isAdmin;
}

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
    
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
    }
    else
    {
        _isAdmin = YES;
    }
    
    //// ez a resz cmd+c - cmd+v kompatibilis, generikus nevek vannak, csak a fetch request paramtereket _kell_ atirni!!!!!!!!
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    [self.buszSearchBar setShowsScopeBar:NO];
    [self.buszSearchBar sizeToFit];
    [self.buszSearchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + self.buszSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    /*// itt ird at
    self.cellLabelName = [DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Busz"];
    
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.cellLabelName count]];
     */
    [[self tableView] reloadData];
    /// eddig masold
    
}


// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        if (_isAdmin)
        {
            Auto *site = [[self cellLabelName] objectAtIndex:[indexPath row]];
            [DataBaseUtil autoDelete:[[site autoID] stringValue]];
            [self.cellLabelName removeObjectAtIndex:indexPath.row];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Auto"
                                                            message:@"Adott auto törölve!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            Auto *site = [[self cellLabelName] objectAtIndex:[indexPath row]];
            [self.cellLabelName removeObjectAtIndex:indexPath.row];
            [alert show];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
    }
    
    /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }   */
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    
}



// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredArray count];
    }else{
        return [self.cellLabelName count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /// ezt ne fejeltsd el atirni ha masolod!
    static NSString *CellIdentifier = @"buszCell";
    
    
    /// az autok menunel MINDENHOL ez a cella fog szerepelni, igy ez masolhato.
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
    
    Auto *car= nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        car = [self.filteredArray objectAtIndex:[indexPath row]];
        
        [[cell textLabel] setText:[car autoNev]];
        if ([indexPath row] % 2) {
            [[cell textLabel] setBackgroundColor:UIColorFromRGB(0xA6977C)];
        }else{
            [[cell textLabel] setBackgroundColor:UIColorFromRGB(0xD9B384)];
        }
    }
	else
	{
        car = [self.cellLabelName objectAtIndex:[indexPath row]];
        [[(BuszCell*)cell buszName] setText:[car autoNev]];
        [[(BuszCell*)cell buszTel] setText:[car autoRendszam]];
        [[(BuszCell*)cell buszMail] setText:[NSString stringWithFormat:@"%@ liter",[car autoUzemAnyag].stringValue]];
    }
    
    return cell;
}

#pragma mark - Table view delegate

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    tableView.backgroundColor=UIColorFromRGB(0xA6977C);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (_isAdmin) {
         [self.searchDisplayController setActive:NO animated:YES];
     [self performSegueWithIdentifier:@"buszAdminViewSegue" sender:tableView];
     }else{
         [self.searchDisplayController setActive:NO animated:YES];
     [self performSegueWithIdentifier:@"vehiclesBuszDetails" sender:tableView];
     }
    
   // [self performSegueWithIdentifier:@"vehiclesBuszDetails" sender:tableView];
    //[self.navigationController pushViewController:siteDetailsViewController animated:YES];
}

/// ennek kellene egy osztalyt felvenni.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"vehiclesBuszDetails"] ) {
        VehiclesDetailsViewController *vehiclesDetailsViewController = [segue destinationViewController];
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            vehiclesDetailsViewController.adatDetails = [self.filteredArray objectAtIndex: [indexPath row]];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            vehiclesDetailsViewController.adatDetails = [self.cellLabelName objectAtIndex: [indexPath row]];
        }
        
    }
    else if ( [[segue identifier] isEqualToString:@"buszAdminViewSegue"] )
    {
        CarAdminViewController *siteDetailsViewController = [segue destinationViewController];
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            siteDetailsViewController.adatDetails = [self.filteredArray objectAtIndex: [indexPath row]];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            siteDetailsViewController.adatDetails = [self.cellLabelName objectAtIndex: [indexPath row]];
        }
    }
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.autoNev contains[c] %@) or (SELF.autoRendszam contains[c] %@)",searchText,searchText];
    NSArray *tempArray = [self.cellLabelName filteredArrayUsingPredicate:predicate];
    
    if([scope isEqualToString:@"Név"])
    {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"(SELF.autoNev contains[c] %@)",searchText];
        tempArray = [self.cellLabelName filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Rendszám"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.autoRendszam contains[c] %@",searchText];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    self.filteredArray = [NSMutableArray arrayWithArray:tempArray];
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
-(void)rendezNev
{
    self.cellLabelName = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Busz" :@"autoNev" :[NSNumber numberWithInt:1]]];
    [[self tableView] reloadData];
}

-(void)rendezRendszam
{
    self.cellLabelName = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Busz" :@"autoRendszam" :[NSNumber numberWithInt:1]]];
    [[self tableView] reloadData];
}

-(void)frissit {
    self.cellLabelName = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Busz"]];
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.cellLabelName count]];
    [[self tableView] reloadData];
}
@end
