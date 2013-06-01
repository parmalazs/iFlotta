//
//  CarsTableViewCell.h
//  iFlott
//
//  Created by Csüti on 5/15/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carsLabel;
@property (weak, nonatomic) IBOutlet UILabel *buszLabel;
@property (strong, nonatomic) IBOutlet UILabel *carMail;

@property (strong, nonatomic) IBOutlet UILabel *carTel;
@property (strong, nonatomic) IBOutlet UILabel *carName;
@end
