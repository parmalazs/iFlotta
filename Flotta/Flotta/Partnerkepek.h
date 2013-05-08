//
//  Partnerkepek.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Partner;

@interface Partnerkepek : NSManagedObject

@property (nonatomic, retain) NSNumber * partnerID;
@property (nonatomic, retain) NSString * partnerKepDate;
@property (nonatomic, retain) NSNumber * partnerKepID;
@property (nonatomic, retain) NSString * partnerKepPath;
@property (nonatomic, retain) NSNumber * partnerKepIsUploaded;
@property (nonatomic, retain) Partner *partner;

@end
