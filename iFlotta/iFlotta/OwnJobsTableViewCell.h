//
//  OwnJobsTableViewCell.h
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnJobsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *ownJobLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobTel;
@property (strong, nonatomic) IBOutlet UILabel *jobName;
@property (strong, nonatomic) IBOutlet UILabel *jobMail;

@end
