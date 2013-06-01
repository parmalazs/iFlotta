//
//  DriverTableViewCell.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *driverNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverTelLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverWebLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverEmailLabel;
@property (strong, nonatomic) IBOutlet UIImageView *driverImageView;

@end
