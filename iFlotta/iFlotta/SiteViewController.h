//
//  SiteViewController.h
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDropdown.h"

@interface SiteViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate,DropdownDelegate>
{
    MBDropdown *dropdownSorted;
}

@property IBOutlet UISearchBar *siteSearchBar;
@property (nonatomic, strong) NSMutableArray *siteArray;
@property (strong,nonatomic) NSMutableArray *filteredSiteArray;
@end