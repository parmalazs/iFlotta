//
//  SiteViewController.h
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property IBOutlet UISearchBar *siteSearchBar;
@property (nonatomic, strong) NSArray *siteArray;
@property (strong,nonatomic) NSMutableArray *filteredSiteArray;

@end
