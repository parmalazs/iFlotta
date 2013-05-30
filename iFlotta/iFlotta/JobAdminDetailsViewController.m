//
//  JobAdminDetailsViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.30..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "JobAdminDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface JobAdminDetailsViewController ()

@end

@implementation JobAdminDetailsViewController

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
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
