//
//  SiteDetailsViewController.h
//  iFlott
//
//  Created by Csüti on 5/12/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SiteDetailsViewController : UIViewController
@property (nonatomic, strong) NSManagedObject *siteData;

@property (weak, nonatomic) IBOutlet UILabel *siteName;
@property (weak, nonatomic) IBOutlet UILabel *siteAddress;
@property (weak, nonatomic) IBOutlet UILabel *sitePhone;
@property (weak, nonatomic) IBOutlet UILabel *siteMail;

@end
