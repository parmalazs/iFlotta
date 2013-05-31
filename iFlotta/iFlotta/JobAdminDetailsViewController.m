//
//  JobAdminDetailsViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "JobAdminDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JobAdminDetailsViewController (){
    UITextField* activeField;
}

@end

@implementation JobAdminDetailsViewController
@synthesize scrollView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    
    self.jobsIncomeTextField.delegate =self;
    self.jobsCostsTextField.delegate = self;
    self.jobsFuelTextField.delegate = self;
    self.jobsToolsTextFields.delegate = self;
    self.jobsTypeTextField.delegate = self;
    self.jobsCommentTextField.delegate = self;
    
    self.jobsIncomeLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsIncomeLabel.textColor = UIColorFromRGB(0xFFFFFF);

    self.jobsCostLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsCostLabel.textColor= UIColorFromRGB(0xFFFFFF);
    
    self.jobsFuelLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsFuelLabel.textColor= UIColorFromRGB(0xFFFFFF);
    
    self.jobsToolsLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.jobsToolsLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.jobsTypeLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.jobsTypeLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.jobsCommentLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsCommentLabel.textColor= UIColorFromRGB(0xFFFFFF);
    
    [self registerForKeyboardNotifications];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPushed:(id)sender {
}
// Call this method somewhere in your view controller setup code.

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.

- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height+activeField.frame.size.height*2);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent

- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    activeField = nil;
}

//////////////////// idaig //////////////////////////////

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}
@end
