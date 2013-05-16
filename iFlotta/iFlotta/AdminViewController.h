//
//  AdminViewController.h
//  iFlott
//
//  Created by Csüti on 5/14/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "PagerViewController.h"
#import "CarAddViewController.h"

@interface AdminViewController : PagerViewController <CarAddViewControllerDelegate>
@property (nonatomic, strong) NSMutableArray *cars;
@end
