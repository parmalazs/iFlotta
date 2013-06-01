//
//  PartnerViewController.h
//  iFlott
//
//  Created by Csüti on 5/11/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBDropdown.h"
#import "CSVUtil.h"
#import <MessageUI/MessageUI.h>

@interface PartnerViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate, MFMailComposeViewControllerDelegate> { }
@property IBOutlet UISearchBar *partnerSearchBar;
@property (nonatomic, strong) NSMutableArray *partnerArray;
@property (strong,nonatomic) NSMutableArray *filteredPartnerArray;

-(void)rendezNev;
-(void)rendezCim;
-(void)frissit;
-(void)sendCSV;
@end
