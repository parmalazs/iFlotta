//
//  SiteViewController.m
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "SiteViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"
#import "SiteTableViewCell.h"
#import "SiteDetailsViewController.h"
#import "AdminSiteViewController.h"
#import "Telephely.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface SiteViewController ()

@end


@implementation SiteViewController
{
    BOOL _isAdmin;
}

@synthesize siteSearchBar;
@synthesize filteredSiteArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    self.siteArray =  [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive"]];
    filteredSiteArray = [NSMutableArray arrayWithCapacity:[self.siteArray count]];
    [[self tableView] reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
  
    // Admin ellenőrzés
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Név szerint",@"image" : @"image"},@{@"name" : @"Cim szerint",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:40]];
        
    }else{
        _isAdmin = YES;
        dropdownSorted = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Új telephely",@"image" : @"image"},@{@"name" : @"Név szerint rendezés",@"image" : @"image"},@{@"name" : @"Cim szerint rendezés",@"image":@"image"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:40]];
    }
    
    self.navigationItem.rightBarButtonItem = dropdownSorted.barButton;
    
    
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    [siteSearchBar setShowsScopeBar:NO];
    [siteSearchBar sizeToFit];
    [siteSearchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + siteSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    /*
    self.siteArray = [DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive"];
    filteredSiteArray = [NSMutableArray arrayWithCapacity:[self.siteArray count]];*/
    
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
    // Return the number of rows in the section.
    //return [self.siteArray count];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredSiteArray count];
    }
	else
	{
        return [self.siteArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"siteTableViewCell";
    
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
    
    Telephely *site= nil;
    
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        site = [filteredSiteArray objectAtIndex:[indexPath row]];
        
        [[cell textLabel] setText:[site telephelyNev]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
	else
	{
        site = [self.siteArray objectAtIndex:[indexPath row]];
        [[(SiteTableViewCell*)cell siteName] setText:[site telephelyNev]];
        [[(SiteTableViewCell*)cell siteTel] setText:[site telephelyTelefonszam]];
        [[(SiteTableViewCell*)cell siteMail] setText:[site telephelyEmail]];
    }
    
    return cell;
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
            Telephely *site = [[self siteArray] objectAtIndex:[indexPath row]];
            [DataBaseUtil telephelyDelete:[[site telephelyID] stringValue]];
            [self.siteArray removeObjectAtIndex:indexPath.row];
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Telephely"
                                                            message:@"Adott telephely törölve!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
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


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_isAdmin) {
        [self.searchDisplayController setActive:NO animated:YES];
        [self performSegueWithIdentifier:@"siteAdminDetails" sender:tableView];
    }else{
        [self.searchDisplayController setActive:NO animated:YES];
        [self performSegueWithIdentifier:@"siteDetails" sender:tableView];
    //[self.navigationController pushViewController:siteDetailsViewController animated:YES];
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"siteDetails"] ) {
        SiteDetailsViewController *siteDetailsViewController = [segue destinationViewController];
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            siteDetailsViewController.siteData = [filteredSiteArray objectAtIndex: [indexPath row]];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            siteDetailsViewController.siteData = [self.siteArray objectAtIndex: [indexPath row]];
        }
    }
    else if ( [[segue identifier] isEqualToString:@"siteAdminDetails"] )
    {
        AdminSiteViewController *siteDetailsViewController = [segue destinationViewController];
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            siteDetailsViewController.siteData = [filteredSiteArray objectAtIndex: [indexPath row]];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            siteDetailsViewController.siteData = [self.siteArray objectAtIndex: [indexPath row]];
        }
    }
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredSiteArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.telephelyNev contains[c] %@) or (SELF.telephelyCim contains[c] %@ or SELF.telephelyEmail contains[c] %@ or SELF.telephelyTelefonszam contains[c] %@)",searchText,searchText,searchText,searchText];
    NSArray *tempArray = [self.siteArray filteredArrayUsingPredicate:predicate];
    
    if([scope isEqualToString:@"Név"])
    {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"(SELF.telephelyNev contains[c] %@)",searchText];
        tempArray = [self.siteArray filteredArrayUsingPredicate:scopePredicate];
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
    filteredSiteArray = [NSMutableArray arrayWithArray:tempArray];
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

- (void)didSelectItem:(NSDictionary *)item{
    NSLog(@"%@",item);
    if (_isAdmin)
    {      
        switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
            case 0:
                NSLog(@"0");
                {
                    AdminSiteViewController *adminSiteViewController = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"adminSiteViewController"];
                    adminSiteViewController.siteData = nil;
                    [self.navigationController pushViewController:adminSiteViewController animated:YES];
                }
                
                break;
            case 1:
                {
                    self.siteArray = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive" :@"telephelyNev" :[NSNumber numberWithInt:1]]];
                    [[self tableView] reloadData];
                }
                break;
            default:
                {
                    self.siteArray = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive" :@"telephelyCim" :[NSNumber numberWithInt:1]]];
                    [[self tableView] reloadData];
                }
                break;
        }
    }
    else
    {
        switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
            case 0:
                {
                    self.siteArray = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive" :@"telephelyNev" :[NSNumber numberWithInt:1]]];
                    [[self tableView] reloadData];
                }
                break;
            default:
                {
                    self.siteArray = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive" :@"telephelyCim" :[NSNumber numberWithInt:1]]];
                    [[self tableView] reloadData];
                }
                break;
        }
    }
    
    
    [dropdownSorted dismiss];
}
@end
