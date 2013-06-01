//
//  KamionCell.h
//  iFlott
//
//  Created by Csüti on 5/29/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KamionCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *kamionLabel;

@property (strong, nonatomic) IBOutlet UILabel *kamionName;
@property (strong, nonatomic) IBOutlet UILabel *kamionTel;
@property (strong, nonatomic) IBOutlet UILabel *kamionMail;
@end
