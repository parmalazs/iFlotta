//
//  PartnerTableViewCell.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PartnerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *partnerLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobName;
@property (strong, nonatomic) IBOutlet UILabel *jobTel;
@property (strong, nonatomic) IBOutlet UILabel *jobMail;

@end
