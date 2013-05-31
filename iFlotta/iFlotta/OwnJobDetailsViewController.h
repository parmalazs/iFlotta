//
//  OwnJobDetailsViewController.h
//  iFlott
//
//  Created by  hallgato5 on 2013.05.27..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OwnJobDetailsViewController : UIViewController
@property (nonatomic, strong) NSManagedObject *ownJobData;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute1;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute2;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute3;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute4;
@property (strong, nonatomic) IBOutlet UILabel *jobAttribute5;
- (IBAction)leadButton:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *nevLabel;
@property (strong, nonatomic) IBOutlet UILabel *telLabel;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *label4;
@property (strong, nonatomic) IBOutlet UILabel *label5;
@end
