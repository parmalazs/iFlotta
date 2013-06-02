//
//  OwnJobsViewController.m
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "OwnJobsViewController.h"
#import "DataBaseUtil.h"
#import "Munkatipus.h"
#import "Munka.h"
#import "OwnJobsTableViewCell.h"
#import "OwnJobDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface OwnJobsViewController (){
    BOOL _isAdmin;
}

@end

@implementation OwnJobsViewController
@synthesize ownJobsSearchBar;

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
    [ownJobsSearchBar setShowsScopeBar:NO];
    [ownJobsSearchBar sizeToFit];
    [ownJobsSearchBar setTintColor:UIColorFromRGB(0x260B01)];
    
    NSNumber* tmp = [NSNumber numberWithInt:[[DataBaseUtil aktUserAdmin] intValue] ];
    if ([tmp isEqualToNumber:[NSNumber numberWithInt:0]])
    {
        _isAdmin = NO;
    }
    else
    {
        _isAdmin = YES;
    }
    
    CGRect newBounds = [[self tableView] bounds];
    newBounds.origin.y = newBounds.origin.y + ownJobsSearchBar.bounds.size.height;
    [[self tableView] setBounds:newBounds];
    
    self.ownJobsArray = [DataBaseUtil fetchRequestSajatMunkak];
    
    
    //filteredOwnJobsArray = [NSMutableArray arrayWithCapacity:[self.ownJobsArray count]];
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
        return [self.ownJobsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ownJobsTableViewCell";
    
    OwnJobsTableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[OwnJobsTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    if ([indexPath row] % 2) {
        cell.contentView.backgroundColor = UIColorFromRGB(0xA6977C);
    }else{
        cell.contentView.backgroundColor = UIColorFromRGB(0xD9B384);
    }
    
    Munka *job= nil;
    job = [self.ownJobsArray objectAtIndex:[indexPath row]];
    //[[cell ] setText:[job munkaDate]];
    [[cell jobName] setText:[job munkaDate]];
    NSArray * tmp = [DataBaseUtil fetchRequestMunkaTipus:[[job munkatipusID] stringValue]];
    
    Munkatipus * mt = [tmp objectAtIndex:0];
    [[cell jobTel] setText:[mt munkaTipusNev]];
    [[cell jobMail] setText:[job munkaBevetel].stringValue];
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
{/*
    if (_isAdmin) {
        [self performSegueWithIdentifier:@"ownJobsAdminSegue" sender:tableView];
    }else{
        [self performSegueWithIdentifier:@"ownJobDetails" sender:tableView];
    }*/
    [self performSegueWithIdentifier:@"ownJobDetails" sender:tableView];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [[segue identifier] isEqualToString:@"ownJobDetails"] ) {
        OwnJobDetailsViewController *ownJobDetailsViewController = [segue destinationViewController];
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ownJobDetailsViewController.ownJobData = [self.ownJobsArray objectAtIndex: [indexPath row]];
    }
}
-(void)frissit
{
    self.ownJobsArray = [DataBaseUtil fetchRequestSajatMunkak];
    [[self tableView] reloadData];
}

@end
