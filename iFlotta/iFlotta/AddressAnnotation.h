//
//  AddressAnnotation.h
//  iFlott
//
//  Created by hallgato2 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
    NSString *title;
    NSString *subtitle;
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * subtitle;

- (id) initWithCoordinate: (CLLocationCoordinate2D) c; 

@end