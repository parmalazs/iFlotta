//
//  SoforAdminDetailViewController.h
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SoforAdminDetailViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) NSManagedObject *siteData;

@property (strong, nonatomic) IBOutlet UILabel *driverNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverAdressLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverEmailLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverTelLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverWebLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverXLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverYLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverLoginLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverPasswordLabel;
@property (strong, nonatomic) IBOutlet UILabel *driverBirthdateLabel;

@property (strong, nonatomic) IBOutlet UITextField *driverNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverAdressTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverTelTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverWebTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverXTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverYTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverLoginTextField;
@property (strong, nonatomic) IBOutlet UITextField *driverPasswordTextField;

@property (strong, nonatomic) IBOutlet UILabel *driverIsAdminLabel;
@property (strong, nonatomic) IBOutlet UITextField *driverBirthdateTextField;

- (IBAction)saveButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *isAdmin;

@end
