//
//  CarsViewController.h
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarsViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UISearchBar *carsSearchBar;
@property (nonatomic, strong) NSArray *carsLabel;
@end
