//
//  MapPinAnnotation.h
//  iFlott
//
//  Created by  hallgato5 on 2013.06.01..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapPinAnnotation : NSObject <MKAnnotation>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, readonly) NSString* title;
@property (nonatomic, readonly) NSString* subtitle;

- (id)initWithCoordinates:(CLLocationCoordinate2D)location
                placeName:(NSString *)placeName
              description:(NSString *)description;

@end