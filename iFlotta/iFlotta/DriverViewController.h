//
//  DriverViewController.h
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDropdown.h"
#import "CSVUtil.h"
#import <MessageUI/MessageUI.h>

@interface DriverViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, MFMailComposeViewControllerDelegate> { }
@property (weak, nonatomic) IBOutlet UISearchBar *driverSearchBar;
@property (nonatomic, strong) NSArray *driverArray;
@property (strong,nonatomic) NSMutableArray *filteredDriverArray;


-(void)rendezNev;
-(void)rendezCim;
-(void)sendCSV;
@end
