//
//  JobAdminDetailsViewController.h
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JobAdminDetailsViewController : UIViewController<UITextFieldDelegate>
@property (nonatomic, strong) NSManagedObject *siteData;

/* EZEK MEG KELLENEK! de a scroll view-val.
@dynamic munkaBefejezesDate;
@dynamic munkaDate;
@dynamic munkaEstimatedTime;
@dynamic munkakep;
 */

@property (strong, nonatomic) IBOutlet UILabel *jobsIncomeLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobsCostLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobsFuelLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobsToolsLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobsTypeLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobsCommentLabel;

@property (strong, nonatomic) IBOutlet UITextField *jobsIncomeTextField;
@property (strong, nonatomic) IBOutlet UITextField *jobsCostsTextField;
@property (strong, nonatomic) IBOutlet UITextField *jobsFuelTextField;
@property (strong, nonatomic) IBOutlet UITextField *jobsToolsTextFields;
@property (strong, nonatomic) IBOutlet UITextField *jobsTypeTextField;
@property (strong, nonatomic) IBOutlet UITextField *jobsCommentTextField;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)saveButtonPushed:(id)sender;

@end
