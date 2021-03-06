//
//  PartnerViewController.m
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "PartnerViewController.h"
#import "DataBaseUtil.h"
#import "Partner.h"
#import "PartnerTableViewCell.h"
#import "PartnerDetailsViewController.h"
#import "ContactsAdminViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface PartnerViewController (){
    BOOL _isAdmin;
}

@end

@implementation PartnerViewController
{
    NSNumber *_sort;
}
@synthesize partnerSearchBar;
@synthesize filteredPartnerArray;

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
    
    
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    [partnerSearchBar setShowsScopeBar:NO];
    [partnerSearchBar sizeToFit];
    [partnerSearchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + partnerSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    /*
    self.partnerArray = [DataBaseUtil fetchRequest:@"Partner" :@"1" :@"partnerIsActive"];
    filteredPartnerArray = [NSMutableArray arrayWithCapacity:[self.partnerArray count]];
     */
    
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
        return [filteredPartnerArray count];
    }
	else
	{
        return [self.partnerArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"partnerTableViewCell";
    
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
    
    Partner *partner= nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        partner = [filteredPartnerArray objectAtIndex:[indexPath row]];
        
        [[cell textLabel] setText:[partner partnerNev]];
        if ([indexPath row] % 2) {
            [[cell textLabel] setBackgroundColor:UIColorFromRGB(0xA6977C)];
        }else{
            [[cell textLabel] setBackgroundColor:UIColorFromRGB(0xD9B384)];
        }
    }
	else
	{
        partner = [self.partnerArray objectAtIndex:[indexPath row]];
        NSLog(@"Partner: %@",[partner partnerNev]);
        [[(PartnerTableViewCell*)cell jobName] setText:[partner partnerNev]];
        [[(PartnerTableViewCell*)cell jobTel] setText:[partner partnerTelefonszam]];
        [[(PartnerTableViewCell*)cell jobMail] setText:[partner partnerEmailcim]];
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

-(void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView{
    tableView.backgroundColor=UIColorFromRGB(0xA6977C);
}

 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
     
     if (_isAdmin)
     {
         Partner *site = [[self partnerArray] objectAtIndex:[indexPath row]];
         [DataBaseUtil partnerDelete:[[site partnerID] stringValue]];
         [self.partnerArray removeObjectAtIndex:indexPath.row];
     }
     else
     {
         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Partner"
                                                         message:@"Adott partner törölve!"
                                                        delegate:nil
                                               cancelButtonTitle:@"OK"
                                               otherButtonTitles:nil];
         Partner *site = [[self partnerArray] objectAtIndex:[indexPath row]];
         [self.partnerArray removeObjectAtIndex:indexPath.row];
         [alert show];
     }
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
     [tableView reloadData];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
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
            [self performSegueWithIdentifier:@"contactsAdminViewSegue" sender:tableView];
        }else{
            [self.searchDisplayController setActive:NO animated:YES];
            [self performSegueWithIdentifier:@"partnerDetails" sender:tableView];
        }
        
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"partnerDetails"] ) {
        PartnerDetailsViewController *partnerDetailsViewController = [segue destinationViewController];
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            partnerDetailsViewController.partnerData = [filteredPartnerArray objectAtIndex: [indexPath row]];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            partnerDetailsViewController.partnerData = [self.partnerArray objectAtIndex: [indexPath row]];
        }
        
    }
    else
        if ( [[segue identifier] isEqualToString:@"contactsAdminViewSegue"] ) {
            ContactsAdminViewController *partnerDetailsViewController = [segue destinationViewController];
            
            if(sender == self.searchDisplayController.searchResultsTableView) {
                NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
                partnerDetailsViewController.siteData = [filteredPartnerArray objectAtIndex: [indexPath row]];
            }
            else {
                NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
                partnerDetailsViewController.siteData = [self.partnerArray objectAtIndex: [indexPath row]];
            }
            
        }
}

#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredPartnerArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.partnerNev contains[c] %@) or (SELF.partnerCim contains[c] %@)",searchText,searchText];
    NSArray *tempArray = [self.partnerArray filteredArrayUsingPredicate:predicate];
    
    if([scope isEqualToString:@"Név"])
    {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"(SELF.partnerNev contains[c] %@)",searchText];
        tempArray = [self.partnerArray filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Cim"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.partnerCim contains[c] %@",searchText];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    filteredPartnerArray = [NSMutableArray arrayWithArray:tempArray];
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
    self.partnerArray = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Partner" :@"1" :@"partnerIsActive" :@"partnerNev" :[NSNumber numberWithInt:1]]];
    [[self tableView] reloadData];
}

-(void)rendezCim
{
    self.partnerArray = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Partner" :@"1" :@"partnerIsActive" :@"partnerCim" :[NSNumber numberWithInt:1]]];
    [[self tableView] reloadData];
}

-(void)frissit
{
    self.partnerArray = [NSMutableArray arrayWithArray:[DataBaseUtil fetchRequest:@"Partner" :@"1" :@"partnerIsActive"]];
    filteredPartnerArray = [NSMutableArray arrayWithCapacity:[self.partnerArray count]];
    [[self tableView] reloadData];
}

-(void)sendCSV {
    NSMutableArray *partnersName=[NSMutableArray arrayWithCapacity:[self.partnerArray count]] ;
    for (id akt in self.partnerArray) {
        [partnersName addObject:[akt partnerNev]];
    }
    NSMutableArray *partnersPhone=[NSMutableArray arrayWithCapacity:[self.partnerArray count]] ;
    for (id akt in self.partnerArray) {
        [partnersPhone addObject:[akt partnerTelefonszam]];
    }
    NSMutableArray *partnersEmail=[NSMutableArray arrayWithCapacity:[self.partnerArray count]] ;
    for (id akt in self.partnerArray) {
        [partnersEmail addObject:[akt partnerEmailcim]];
    }
    
    NSString *csv=[CSVUtil PartnerToCSV:partnersName :partnersPhone :partnersEmail];
    NSData *attachment=[NSData dataWithContentsOfFile:csv];
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
    
    [picker setSubject:@"message via iFlotta"];
    
    // Fill out the email body text
    [picker addAttachmentData:attachment mimeType:@"text/csv" fileName:@"partners.csv"];
    
    
    picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
    
    [self presentModalViewController:picker animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            
            break;
    }
    [self dismissModalViewControllerAnimated:YES];
}



@end
