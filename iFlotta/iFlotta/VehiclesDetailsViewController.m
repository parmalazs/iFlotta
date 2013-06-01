//
//  VehiclesDetailsViewController.m
//  iFlott
//
//  Created by hallgato1 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "VehiclesDetailsViewController.h"
#import "DataBaseUtil.h"
#import "JsonUtil.h"


#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface VehiclesDetailsViewController ()

@end

@implementation VehiclesDetailsViewController
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
    
    //self.profilImage.image=[self.adatDetails valueForKey:@"autoKep"];
    self.name.text = [self.adatDetails valueForKey:@"autoNev"];
    self.vehicleType.text = [self.adatDetails valueForKey:@"autoTipus"];
    self.speedometer.text = [[self.adatDetails valueForKey:@"autoKilometerOra"] stringValue];
    self.fuel.text = [[self.adatDetails valueForKey:@"autoUzemAnyag"] stringValue];
    
    self.vehicleType.backgroundColor = UIColorFromRGB(0xD9B384);
    self.speedometer.backgroundColor = UIColorFromRGB(0xD9B384);
    self.fuel.backgroundColor = UIColorFromRGB(0xD9B384);
    
    /// labelek
    self.name.backgroundColor = UIColorFromRGB(0x260B01);
    self.name.textColor = UIColorFromRGB(0xD9B384);
    self.benzin.backgroundColor = UIColorFromRGB(0x46594B);
    self.benzin.textColor = UIColorFromRGB(0xFFFFFF);
    self.km.backgroundColor = UIColorFromRGB(0x46594B);
    self.km.textColor = UIColorFromRGB(0xFFFFFF);
    self.tipus.backgroundColor = UIColorFromRGB(0x46594B);
    self.tipus.textColor = UIColorFromRGB(0xFFFFFF);
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?center=%f,%f&markers=%f,%f&%@&sensor=true",[[self.adatDetails valueForKey:@"autoXkoordinata"] floatValue], [[self.adatDetails valueForKey:@"autoYkoordinata"] floatValue],[[self.adatDetails valueForKey:@"autoXkoordinata"] floatValue], [[self.adatDetails valueForKey:@"autoYkoordinata"] floatValue],@"zoom=13&size=200x200"];
    
    NSLog(staticMapUrl);
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    self.mapImage.image = image;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)foglalasButtonPushed:(id)sender {
    
   // +(BOOL)autoFoglal:(NSString*) autoID
    if ([DataBaseUtil autoFoglal:[[self adatDetails] valueForKey:@"autoID"] ])
    {
        // Alert kell ide!!!!
        NSLog(@"Foglalt");
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Jármű"
                                                        message:@"Az adott jármű már foglalt, kérem válasszon másikat!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        NSLog(@"Felvéve");
        [DataBaseUtil autoFoglal:[[self adatDetails] valueForKey:@"autoID"] :[NSNumber numberWithInt:1] ];
        
        NSArray *obj = [DataBaseUtil fetchRequestEntity:@"Auto" :@"autoID" :[[self adatDetails] valueForKey:@"autoID"] ];
        
        [JsonUtil JsonBuilderSender:obj :@"Auto" :@"update"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Jármű"
                                                        message:@"Az adott járművet lefoglalta!"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
    
}
@end
