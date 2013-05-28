//
//  CarAddViewController.h
//  iFlott
//
//  Created by Csüti on 5/16/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Auto.h"


@class CarAddViewController;
@class Auto;

@protocol CarAddViewControllerDelegate <NSObject>

- (void)carAddViewControllerDidCancel:(CarAddViewController *)controller;
- (void)carAddViewController:(CarAddViewController *)controller didAddCar:(NSString *)car;
@end

@interface CarAddViewController : UITableViewController
@property (nonatomic, weak) id <CarAddViewControllerDelegate> delegate;
- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
