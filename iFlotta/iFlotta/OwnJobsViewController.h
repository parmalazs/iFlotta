//
//  OwnJobsViewController.h
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnJobsViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *ownJobsSearchBar;
@property (nonatomic, strong) NSArray *ownJobsArray;
@property (strong,nonatomic) NSMutableArray *filteredOwnJobsArray;

@end
