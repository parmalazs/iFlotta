//
//  SiteTableViewCell.h
//  iFlott
//
//  Created by Csüti on 5/12/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *siteLabel;

@property (strong, nonatomic) IBOutlet UILabel *siteName;
@property (strong, nonatomic) IBOutlet UILabel *siteTel;
@property (strong, nonatomic) IBOutlet UILabel *siteMail;

@end
