//
//  AdminSiteViewController.h
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AdminSiteViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) NSManagedObject *siteData;

@property (strong, nonatomic) IBOutlet UILabel *siteNevLabel;
@property (strong, nonatomic) IBOutlet UILabel *cimLabel;
@property (strong, nonatomic) IBOutlet UILabel *telLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;

@property (strong, nonatomic) IBOutlet UITextField *siteNevTextField;
@property (strong, nonatomic) IBOutlet UITextField *cimTextField;
@property (strong, nonatomic) IBOutlet UITextField *telTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UILabel *xLabel;
@property (strong, nonatomic) IBOutlet UILabel *yLabel;
@property (strong, nonatomic) IBOutlet UITextField *xTextField;
@property (strong, nonatomic) IBOutlet UITextField *yTextField;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)makePhotoButtonPressed:(id)sender;
- (IBAction)saveButton:(id)sender;

@end
