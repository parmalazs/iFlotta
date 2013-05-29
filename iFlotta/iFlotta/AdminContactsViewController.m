//
//  AdminContactsViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "AdminContactsViewController.h"

@interface AdminContactsViewController (){
    NSMutableArray* _partners;
    NSArray* _partnerpics;
}

@end

@implementation AdminContactsViewController

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
    [self fetchDatas];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_partners count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    Partner* partner = [_partners objectAtIndex:indexPath.row];
    UILabel *label= (UILabel*)[self.view viewWithTag: 2];
    label.text = partner.partnerNev;
    label = (UILabel*)[self.view viewWithTag:1];
    label.text = partner.partnerWeboldal;
    
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
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

-(void)fetchDatas{
    // fetching partners
    NSManagedObjectContext* context =
    [[AppDelegate sharedAppDelegate] managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init]; NSEntityDescription *entity = [NSEntityDescription entityForName:@"Partner" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSError *error;
    _partners = [context executeFetchRequest:fetchRequest error:&error];
    
    // fetching partnerPictures
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"Partnerkepek" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    _partnerpics = [context executeFetchRequest:fetchRequest error:&error];
}

- (IBAction)addButtonTapped:(id)sender {
    UIAlertView* alertView =
    [[UIAlertView alloc] initWithTitle:@"Új partner"
                               message:@"Neve:" delegate:self cancelButtonTitle:@"Mégse" otherButtonTitles:@"Mentés", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
//    alertView.backgroundColor = UIColorFromRGB(0x260B01); apple nem engedi. ..I.. 
    [alertView show];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSString* content = [[alertView textFieldAtIndex:0] text];
        NSManagedObjectContext* context = [[AppDelegate sharedAppDelegate] managedObjectContext];
        NSEntityDescription* noteEntity = [NSEntityDescription entityForName:@"Partner" inManagedObjectContext:context];
        Partner* partner = (Partner *)[[NSManagedObject alloc] initWithEntity:noteEntity insertIntoManagedObjectContext:context];
        partner.partnerNev = content;
        if ([content length] < 30)
            partner.partnerNev = content; else
                partner.partnerNev = [content substringToIndex:30];
        //[_partners addObject:partner];
    }
}
@end
