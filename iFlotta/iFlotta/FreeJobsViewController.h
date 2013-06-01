//
//  FreeJobsViewController.h
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeJobsViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *freeJobsSearchBar;
@property (nonatomic, strong) NSArray *freeJobsArray;
@property (strong,nonatomic) NSMutableArray *filteredFreeJobsArray;

-(void)rendezKoltseg;
-(void)rendezDatum;
-(void)frissit;

@end
