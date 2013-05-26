//
//  Partnerkepek.h
//  iFlott
//
//  Created by Csüti on 5/26/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Partner;

@interface Partnerkepek : NSManagedObject

@property (nonatomic, retain) NSNumber * partnerID;
@property (nonatomic, retain) NSString * partnerKepDate;
@property (nonatomic, retain) NSNumber * partnerKepID;
@property (nonatomic, retain) NSNumber * partnerKepIsUploaded;
@property (nonatomic, retain) NSString * partnerKepPath;
@property (nonatomic, retain) NSNumber * partnerKepIsActive;
@property (nonatomic, retain) Partner *partner;

@end
