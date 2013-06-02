//
//  JobAdminDetailsViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "JobAdminDetailsViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JobAdminDetailsViewController (){
    UITextField* activeField;
    NSArray* labelElements;
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
    /*
     @dynamic munkaBefejezesDate;
     @dynamic munkaBevetel;
     @dynamic munkaComment;
     @dynamic munkaDate;
     @dynamic munkaEstimatedTime;
     @dynamic munkaID;
     @dynamic munkaIsActive;
     @dynamic munkaKoltseg;
     @dynamic munkatipusID;
     @dynamic munkaUzemanyagState;
     @dynamic partnerID;
     @dynamic soforID;
     @dynamic telephelyID;
     @dynamic munkaeszkoz;
     @dynamic munkakep;
     @dynamic munkatipus;
     @dynamic partner;
     @dynamic sofor;
     @dynamic telephely;
     */
    self.jobsIncomeTextField.delegate =self;
    self.jobsIncomeTextField.text = [[self.siteData valueForKey:@"munkaBevetel"] stringValue];
    self.jobsCostsTextField.delegate = self;
    self.jobsCostsTextField.text = [[self.siteData valueForKey:@"munkaKoltseg"]  stringValue];
    self.jobsFuelTextField.delegate = self;
    self.jobsFuelTextField.text = [[self.siteData valueForKey:@"munkaUzemanyagState"] stringValue];
   // self.jobsToolsTextFields.delegate = self;

    self.jobsTypeTextField.delegate = self;
    self.jobsCommentTextField.delegate = self;
    
    self.jobsIncomeLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsIncomeLabel.textColor = UIColorFromRGB(0xFFFFFF);

    self.jobsCostLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsCostLabel.textColor= UIColorFromRGB(0xFFFFFF);
    
    self.jobsFuelLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsFuelLabel.textColor= UIColorFromRGB(0xFFFFFF);
    
//    self.jobsToolsLabel.backgroundColor = UIColorFromRGB(0x46594B);
//    self.jobsToolsLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    self.jobsTypeLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.jobsTypeLabel.textColor = UIColorFromRGB(0xFFFFFF);
    
    NSArray * tmp = [DataBaseUtil fetchRequestMunkaTipus:[[[self siteData] valueForKey:@"munkatipusID"] stringValue]];
    
    Munkatipus * mt = [tmp objectAtIndex:0];
    self.jobsTypeTextField.text = [mt munkaTipusNev];
    
    self.jobsCommentLabel.backgroundColor= UIColorFromRGB(0x46594B);
    self.jobsCommentLabel.textColor= UIColorFromRGB(0xFFFFFF);
    self.jobsCommentTextField.delegate = self;
    self.jobsCommentTextField.text = [self.siteData valueForKey:@"munkaComment"];
    [self registerForKeyboardNotifications];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveButtonPushed:(id)sender {
    NSNumber *maxid = [DataBaseUtil fetchRequestMaxID:@"Munka" :@"munkaID"];
    
    int value = [maxid intValue];
    maxid = [NSNumber numberWithInt:value + 1];
    
    labelElements = [[NSArray alloc]
                     initWithObjects:_jobsCostsTextField.text,
                     _jobsIncomeTextField.text,
                     _jobsFuelTextField.text,
                     _jobsCostsTextField.text,
                     _jobsTypeTextField.text,
                     _jobsCommentTextField.text,
                     nil];
    
    
    if (![DataBaseUtil IsInsert:labelElements])
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Munka"
                                                        message:@"Kérem töltsön ki minden mezőt!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        
        if (self.siteData == nil)
        {
            [DataBaseUtil insertMunka:@"2012.02.12" :[[NSNumber alloc] initWithInt:[[_jobsIncomeTextField text] intValue] ] :_jobsCommentTextField.text :@"2012.02.12" :@"2012.02.12" :[[NSNumber alloc] initWithInt:[maxid intValue]] :[[NSNumber alloc] initWithInt:1] :[[NSNumber alloc] initWithInt:[[_jobsCostsTextField text] intValue]] :[[NSNumber alloc] initWithInt:[[_jobsTypeTextField text] intValue]] :[[NSNumber alloc] initWithInt:[[_jobsFuelTextField text] intValue]] :[[NSNumber alloc] initWithInt:1] :[[NSNumber alloc] initWithInt:1] :[[NSNumber alloc] initWithInt:1]];
            
            
            NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Munka" :@"munkaID" :[maxid stringValue]];
            NSLog(@"%@",[obj objectAtIndex:0]);
            [JsonUtil JsonBuilderSender:obj :@"Munka" :@"insert"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Munka"
                                                            message:@"Új munka felvéve!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        else
        {
            [DataBaseUtil updateMunka:@"2012.02.12" :[[NSNumber alloc] initWithInt:[[_jobsIncomeTextField text] intValue] ] :_jobsCommentTextField.text :@"2012.02.12" :@"2012.02.12" :[[NSNumber alloc] initWithInt:[[self.siteData valueForKey:@"munkaID"] intValue]] :[[NSNumber alloc] initWithInt:1] :[[NSNumber alloc] initWithInt:[[_jobsCostsTextField text] intValue]] :[[NSNumber alloc] initWithInt:[[_jobsTypeTextField text] intValue]] :[[NSNumber alloc] initWithInt:[[_jobsFuelTextField text] intValue]] :[[NSNumber alloc] initWithInt:1] :[[NSNumber alloc] initWithInt:1] :[[NSNumber alloc] initWithInt:1]];
            
            
            NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Munka" :@"munkaID" :[[self.siteData valueForKey:@"munkaID"] stringValue]];
            NSLog(@"%@",[obj objectAtIndex:0]);
            [JsonUtil JsonBuilderSender:obj :@"Munka" :@"update"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Munka"
                                                            message:@"Munka módositva!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }

        [self.navigationController popViewControllerAnimated: YES];
    }
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
