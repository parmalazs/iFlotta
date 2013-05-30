//
//  AddressAnnotation.m
//  iFlott
//
//  Created by hallgato2 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "AddressAnnotation.h"

@implementation AddressAnnotation
@synthesize coordinate;

@synthesize title;
@synthesize subtitle;

- (NSString *)title {
    return title;
}

- (NSString *)subtitle {
    return subtitle;
}


-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	return self;
}

@end