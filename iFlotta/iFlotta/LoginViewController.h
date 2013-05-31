//
//  LoginViewController.h
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
 
@interface LoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPassword;
@property (strong, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *userPasswordLabel;

@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UIImageView *pic1;
@property (strong, nonatomic) IBOutlet UIImageView *pic2;
@property (strong, nonatomic) IBOutlet UIImageView *pic3;
@property (strong, nonatomic) IBOutlet UIImageView *pic4;

- (IBAction)userLoginButton:(id)sender;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

@end
