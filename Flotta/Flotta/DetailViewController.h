//
//  DetailViewController.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.07..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
