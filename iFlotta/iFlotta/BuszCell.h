//
//  BuszCell.h
//  iFlott
//
//  Created by Csüti on 5/29/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuszCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *buszName;

@property (strong, nonatomic) IBOutlet UILabel *buszMail;
@property (strong, nonatomic) IBOutlet UILabel *buszTel;

@end
