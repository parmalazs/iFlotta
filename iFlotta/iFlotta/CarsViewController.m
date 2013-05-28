//
//  CarsViewController.m
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "CarsViewController.h"
#import "DataBaseUtil.h"
#import "CarsTableViewCell.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface CarsViewController ()

@end

@implementation CarsViewController

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
    
    
    //// ez a resz cmd+c - cmd+v kompatibilis, generikus nevek vannak, csak a fetch request paramtereket _kell_ atirni!!!!!!!!
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    [self.searchBar setShowsScopeBar:NO];
    [self.searchBar sizeToFit];
    [self.searchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + self.searchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    // itt ird at
    self.cellLabelName = [DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Személygépjármű"];
    
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.cellLabelName count]];
    [[self tableView] reloadData];
    /// eddig masold
    
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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [self.filteredArray count];
    }else{
        return [self.cellLabelName count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /// ezt ne fejeltsd el atirni ha masolod!
    static NSString *CellIdentifier = @"carsTableViewCell";
    
    
    /// az autok menunel MINDENHOL ez a cella fog szerepelni, igy ez masolhato.
    CarsTableViewCell *cell = [tableView
                               dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CarsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    if ([indexPath row] % 2) {
        cell.contentView.backgroundColor = UIColorFromRGB(0xA6977C);
    }else{
        cell.contentView.backgroundColor = UIColorFromRGB(0xD9B384);
    }
    
    
    // ezt se felejtsd atirni
    cell.carsLabel.text = [[self.cellLabelName objectAtIndex: [indexPath row]] valueForKey:@"autoNev"];
    
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
}


/// ennek kellene egy osztalyt felvenni.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
//    if ( [[segue identifier] isEqualToString:@"siteDetails"] ) {
//        CarDetailsViewController *siteDetailsViewController = [segue destinationViewController];
//        
//        if(sender == self.searchDisplayController.searchResultsTableView) {
//            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
//            siteDetailsViewController.siteData = [self.filteredArray objectAtIndex: [indexPath row]];
//        }
//        else {
//            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//            siteDetailsViewController.siteData = [self.cellLabelName objectAtIndex: [indexPath row]];
//        }
    
 //   }
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.telephelyNev contains[c] %@) or (SELF.telephelyCim contains[c] %@ or (SELF.telephelyEmail contains[c] %@ or (SELF.telephelyTelefonszam contains[c] %@)",searchText,searchText,searchText,searchText];
    NSArray *tempArray = [self.cellLabelName filteredArrayUsingPredicate:predicate];
    
    if([scope isEqualToString:@"Név"])
    {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"(SELF.telephelyNev contains[c] %@)",searchText];
        tempArray = [self.cellLabelName filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Cim"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.telephelyCim contains[c] %@",searchText];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Email"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.telephelyEmail contains[c] %@",searchText];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Tel"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.telephelyTelefonszam contains[c] %@",searchText];
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

@end
