//
//  PartnerDetailsViewController.m
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "PartnerDetailsViewController.h"
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface PartnerDetailsViewController ()

@end

@implementation PartnerDetailsViewController

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
    self.view.backgroundColor=UIColorFromRGB(0xA6977C);
    
    self.partnerNev.text            = [self.partnerData valueForKey:@"partnerNev"];
    self.partnerCim.text            = [self.partnerData valueForKey:@"partnerCim"];
    self.partnerTelefonszam.text    = [self.partnerData valueForKey:@"partnerTelefonszam"];
    self.PartnerEmail.text          = [self.partnerData valueForKey:@"partnerEmailcim"];
    
    self.partnerCim.backgroundColor         = UIColorFromRGB(0xD9B384);
    self.partnerNev.backgroundColor         = UIColorFromRGB(0x260B01);
    self.partnerNev.textColor               = UIColorFromRGB(0xD9B384);
    self.partnerTelefonszam.backgroundColor = UIColorFromRGB(0xD9B384);
    self.PartnerEmail.backgroundColor       = UIColorFromRGB(0xD9B384);
    
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

- (IBAction)callPartner:(id)sender {
    NSString *dial=[[NSString alloc] init];
    dial=@"telprompt://";
    NSString *number=[[NSString alloc] init];
    number=[self.partnerData valueForKey:@"partnerTelefonszam"];
    NSLog([NSString stringWithFormat:@"%@%@", dial, number]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", dial, number]]];
}

- (IBAction)messagePartner:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        [self showEmailModalView];
    }
    
}

-(void) showEmailModalView {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self; // &lt;- very important step if you want feedbacks on what the user did with your email sheet
    
    [picker setSubject:@"message via iFlotta"];
    
    // Fill out the email body text
    NSArray *toRecipients = [NSArray arrayWithObjects:[self.partnerData valueForKey:@"partnerEmailcim"], nil];
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
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent:
            break;
        case MFMailComposeResultFailed:
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
