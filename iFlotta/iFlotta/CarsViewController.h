//
//  CarsViewController.h
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarsViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) NSMutableArray *cellLabelName;
@property (strong, nonatomic) NSMutableArray *filteredArray;

-(void)rendezNev;

-(void)rendezRendszam;
-(void)frissit;

@end
