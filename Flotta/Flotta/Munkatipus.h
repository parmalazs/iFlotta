//
//  Munkatipus.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Munka;

@interface Munkatipus : NSManagedObject

@property (nonatomic, retain) NSNumber * munkaTipusID;
@property (nonatomic, retain) NSString * munkaTipusNev;
@property (nonatomic, retain) NSSet *munka;
@end

@interface Munkatipus (CoreDataGeneratedAccessors)

- (void)addMunkaObject:(Munka *)value;
- (void)removeMunkaObject:(Munka *)value;
- (void)addMunka:(NSSet *)values;
- (void)removeMunka:(NSSet *)values;

@end
