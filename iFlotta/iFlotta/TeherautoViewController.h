//
//  TeherautoViewController.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeherautoViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (strong, nonatomic) IBOutlet UISearchBar *teherautoSearchBar;
@property (nonatomic, strong) NSArray *cellLabelName;
@property (strong, nonatomic) NSMutableArray *filteredArray;
@end
