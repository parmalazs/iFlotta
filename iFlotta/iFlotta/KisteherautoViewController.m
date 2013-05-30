//
//  KisteherautoViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "KisteherautoViewController.h"
#import "DataBaseUtil.h"
#import "KisteherautoCell.h"
#import "VehiclesDetailsViewController.h"
#import "Auto.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface KisteherautoViewController ()

@end

@implementation KisteherautoViewController
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
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUser] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
    }
    else
    {
        _isAdmin = YES;
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    [self.kisteherautoSearchBar setShowsScopeBar:NO];
    [self.kisteherautoSearchBar sizeToFit];
    [self.kisteherautoSearchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + self.kisteherautoSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    self.cellLabelName = [DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Kisteherautó"];
    
    self.filteredArray = [NSMutableArray arrayWithCapacity:[self.cellLabelName count]];
    [[self tableView] reloadData];
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
    static NSString *CellIdentifier = @"kisteherautoCell";
    
    
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
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
	else
	{
        car = [self.cellLabelName objectAtIndex:[indexPath row]];
        NSLog(@"LOG: %@",[car autoNev]);
        [[(KisteherautoCell*)cell kisteherautoLabel] setText:[car autoNev]];
    }
    
    return cell;
}

#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
     if (_isAdmin) {
     [self performSegueWithIdentifier:@"kisteherautoAdminViewSegue" sender:tableView];
     }else{
     [self performSegueWithIdentifier:@"vehiclesKisteherautoDetails" sender:tableView];
     }
    //[self performSegueWithIdentifier:@"vehiclesKisteherautoDetails" sender:tableView];
    //[self.navigationController pushViewController:siteDetailsViewController animated:YES];
}

/// ennek kellene egy osztalyt felvenni.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"vehiclesKisteherautoDetails"] ) {
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
    self.cellLabelName = [DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Kisteherautó" :@"autoNev" :[NSNumber numberWithInt:1]];
    [[self tableView] reloadData];
}

-(void)rendezRendszam
{
    self.cellLabelName = [DataBaseUtil fetchRequestJarmu:@"Auto" :@"1" :@"autoIsActive" :@"Kisteherautó" :@"autoRendszam" :[NSNumber numberWithInt:1]];
    [[self tableView] reloadData];
}
@end
