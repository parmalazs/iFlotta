//
//  FreeJobDetailsViewController.h
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FreeJobDetailsViewController : UIViewController
@property (nonatomic, strong) NSManagedObject *freeJobData;

@property (strong, nonatomic) IBOutlet UILabel *jobAttribute1;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute2;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute3;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute4;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute5;

@property (strong, nonatomic) IBOutlet UILabel *nevLabel;
@property (strong, nonatomic) IBOutlet UILabel *telLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) IBOutlet UILabel *label5;
- (IBAction)felveszButton:(id)sender;

@end
