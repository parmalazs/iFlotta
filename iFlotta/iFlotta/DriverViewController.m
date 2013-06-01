//
//  DriverViewController.m
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "DriverViewController.h"
#import "DriverTableViewCell.h"
#import "DriverDetailsViewController.h"
#import "DataBaseUtil.h"
#import "Sofor.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface DriverViewController (){
    BOOL _isAdmin;
}

@end

@implementation DriverViewController
@synthesize driverSearchBar;
@synthesize filteredDriverArray;
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
    
    [driverSearchBar setShowsScopeBar:NO];
    [driverSearchBar sizeToFit];
    [driverSearchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + driverSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    
    self.driverArray = [DataBaseUtil fetchRequest:@"Sofor" :@"1" :@"soforIsActive"];
    
    
    filteredDriverArray = [NSMutableArray arrayWithCapacity:[self.driverArray count]];
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
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [filteredDriverArray count];
    }
	else
	{
        return [self.driverArray count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"driverTableViewCell";
    
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
    
    Sofor *driver= nil;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        driver = [filteredDriverArray objectAtIndex:[indexPath row]];
        
        [[cell textLabel] setText:[driver soforNev]];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }
	else
	{
        driver = [self.driverArray objectAtIndex:[indexPath row]];
        [[(DriverTableViewCell*)cell driverLabel] setText:[driver soforNev]];
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
#pragma mark - Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isAdmin) {
        [self performSegueWithIdentifier:@"driversAdminViewSegue" sender:tableView];
    }else{
        [self performSegueWithIdentifier:@"driverDetails" sender:tableView];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"driverDetails"] ) {
        DriverDetailsViewController *driverDetailsViewController = [segue destinationViewController];
        
        if(sender == self.searchDisplayController.searchResultsTableView) {
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
            driverDetailsViewController.driverData = [filteredDriverArray objectAtIndex: [indexPath row]];
        }
        else {
            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
            driverDetailsViewController.driverData = [self.driverArray objectAtIndex: [indexPath row]];
        }
        
    }
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	// Update the filtered array based on the search text and scope.
	
    // Remove all objects from the filtered search array
	[self.filteredDriverArray removeAllObjects];
    
	// Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(SELF.soforNev contains[c] %@) or (SELF.soforCim contains[c] %@)",searchText,searchText];
    NSArray *tempArray = [self.driverArray filteredArrayUsingPredicate:predicate];
    
    if([scope isEqualToString:@"Név"])
    {
        // Further filter the array with the scope
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"(SELF.soforNev contains[c] %@)",searchText];
        tempArray = [self.driverArray filteredArrayUsingPredicate:scopePredicate];
    }
    else if([scope isEqualToString:@"Cim"])
    {
        NSPredicate *scopePredicate = [NSPredicate predicateWithFormat:@"SELF.soforCim contains[c] %@",searchText];
        tempArray = [tempArray filteredArrayUsingPredicate:scopePredicate];
    }
    
    filteredDriverArray = [NSMutableArray arrayWithArray:tempArray];
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
    self.driverArray = [DataBaseUtil fetchRequest:@"Sofor" :@"1" :@"soforIsActive" :@"soforNev" :[NSNumber numberWithInt:1]];
    [[self tableView] reloadData];
}
-(void)rendezCim
{
    self.driverArray = [DataBaseUtil fetchRequest:@"Sofor" :@"1" :@"soforIsActive" :@"soforCim" :[NSNumber numberWithInt:1]];
    [[self tableView] reloadData];
}

-(void)sendCSV {
    NSMutableArray *driversName=[NSMutableArray arrayWithCapacity:[self.driverArray count]] ;
    for (id akt in self.driverArray) {
        [driversName addObject:[akt soforNev]];
    }
    NSMutableArray *driversPhone=[NSMutableArray arrayWithCapacity:[self.driverArray count]] ;
    for (id akt in self.driverArray) {
        [driversPhone addObject:[akt soforTelefonszam]];
    }
    NSMutableArray *driversEmail=[NSMutableArray arrayWithCapacity:[self.driverArray count]] ;
    for (id akt in self.driverArray) {
        [driversEmail addObject:[akt soforEmail]];
    }
    
    NSString *csv=[CSVUtil SoforToCSV:driversName :driversPhone :driversEmail];
    NSData *attachment=[NSData dataWithContentsOfFile:csv];
    
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
    
    [picker setSubject:@"message via iFlotta"];
    
    // Fill out the email body text
    [picker addAttachmentData:attachment mimeType:@"text/csv" fileName:@"drivers.csv"];
    
    
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
