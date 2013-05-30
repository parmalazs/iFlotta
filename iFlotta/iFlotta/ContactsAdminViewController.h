//
//  ContactsAdminViewController.h
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsAdminViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextField *contactsNameTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactsAdressTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactsEmailTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactsTelTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactsWebTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactsXTextField;
@property (strong, nonatomic) IBOutlet UITextField *contactsYTextField;

@property (strong, nonatomic) IBOutlet UILabel *contactsNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactsAdressLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactsEmailLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactsTelLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactsWebLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactsXLabel;
@property (strong, nonatomic) IBOutlet UILabel *contactsYLabel;


@end
