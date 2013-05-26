//
//  PartnerViewController.h
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property IBOutlet UISearchBar *partnerSearchBar;
@property (nonatomic, strong) NSArray *partnerArray;
@property (strong,nonatomic) NSMutableArray *filteredPartnerArray;
@end
