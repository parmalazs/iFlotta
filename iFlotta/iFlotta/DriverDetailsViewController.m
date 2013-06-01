//
//  DriverDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "DriverDetailsViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface DriverDetailsViewController ()

@end

@implementation DriverDetailsViewController

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
    /// ezeken jelennek meg az adatok
    
    self.view.backgroundColor = UIColorFromRGB(0xA6977C);
    
    self.soforCim.text = [self.driverData valueForKey:@"soforCim"];
    self.soforCim.backgroundColor = UIColorFromRGB(0xD9B384);
    
    self.soforNev.text = [self.driverData valueForKey:@"soforNev"];
    self.soforNev.backgroundColor = UIColorFromRGB(0x260B01);
    self.soforNev.textColor = UIColorFromRGB(0xD9B384);

    self.soforTelefonszam.text = [self.driverData valueForKey:@"soforTelefonszam"];
    self.soforTelefonszam.backgroundColor = UIColorFromRGB(0xD9B384);
    
    self.soforEmail.text = [self.driverData valueForKey:@"soforEmail"];
    self.soforEmail.backgroundColor = UIColorFromRGB(0xD9B384);
    
    /// ezek a labelek
    self.nevLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.nevLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.telLabel.backgroundColor   = UIColorFromRGB(0x46594B);
    self.telLabel.textColor         = UIColorFromRGB(0xFFFFFF);
    self.emailLabel.backgroundColor = UIColorFromRGB(0x46594B);
    self.emailLabel.textColor       = UIColorFromRGB(0xFFFFFF);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)callDriver:(id)sender {
    NSString *dial=[[NSString alloc] init];
    dial=@"telprompt://";
    NSString *number=[[NSString alloc] init];
    number=[self.driverData valueForKey:@"soforTelefonszam"];
    NSLog([NSString stringWithFormat:@"%@%@", dial, number]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", dial, number]]];
}

- (IBAction)endEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        [self showEmailModalView];
    }
}

-(void) showEmailModalView {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
    
    [picker setSubject:@"message via iFlotta"];
    
    // Fill out the email body text
    NSArray *toRecipients = [NSArray arrayWithObjects:[self.driverData valueForKey:@"soforEmail"], nil];
    [picker setToRecipients:toRecipients];
    
    picker.navigationBar.barStyle = UIBarStyleBlack; // choose your style, unfortunately, Translucent colors behave quirky.
    
    [self presentModalViewController:picker animated:YES];
    
}

// Dismisses the email composition interface when users tap Cancel or Send. Proceeds to update the message field with the result of the operation.

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // Notifies users about errors associated with the interface
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Email" message:@"Sending Failed - Unknown Error :-("
                                                           delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
            
            break;

    }
    [self dismissModalViewControllerAnimated:YES];
}

@end
