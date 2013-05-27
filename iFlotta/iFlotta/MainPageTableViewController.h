//
//  MainPageTableViewController.h
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPageTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *ImageElements;
@property (nonatomic, strong) NSArray *labelElements;
@property (nonatomic, strong) UIImage *ImageNavigate;
@property (strong, nonatomic) IBOutlet UINavigationItem *NavBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *adminButton;
@end
