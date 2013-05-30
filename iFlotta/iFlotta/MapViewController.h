//
//  MapViewController.h
//  iFlott
//
//  Created by hallgato2 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MBDropdown.h"

@interface MapViewController : UIViewController <MKMapViewDelegate, DropdownDelegate>
{
     MBDropdown *dropdown;
}
@property (strong, nonatomic) IBOutlet MKMapView *mapView;



@end
