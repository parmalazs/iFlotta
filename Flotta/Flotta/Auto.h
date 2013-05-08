//
//  Auto.h
//  Flotta
//
//  Created by hallgato2 on 2013.05.08..
//  Copyright (c) 2013 schonherz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Autokep, Sofor, Telephely;

@interface Auto : NSManagedObject

@property (nonatomic, retain) NSNumber * autoFoglalt;
@property (nonatomic, retain) NSNumber * autoID;
@property (nonatomic, retain) NSNumber * autoKilometerOra;
@property (nonatomic, retain) NSNumber * autoLastSoforID;
@property (nonatomic, retain) NSString * autoLastSzervizDate;
@property (nonatomic, retain) NSNumber * autoLastTelephelyID;
@property (nonatomic, retain) NSString * autoLastUpDate;
@property (nonatomic, retain) NSString * autoMuszakiVizsgaDate;
@property (nonatomic, retain) NSString * autoNev;
@property (nonatomic, retain) NSNumber * autoProfilKepID;
@property (nonatomic, retain) NSString * autoRendszam;
@property (nonatomic, retain) NSString * autoTipus;
@property (nonatomic, retain) NSNumber * autoUzemAnyag;
@property (nonatomic, retain) NSNumber * autoXkoordinata;
@property (nonatomic, retain) NSNumber * autoYkoordinata;
@property (nonatomic, retain) NSSet *autokep;
@property (nonatomic, retain) Sofor *sofor;
@property (nonatomic, retain) Telephely *telephely;
@end

@interface Auto (CoreDataGeneratedAccessors)

- (void)addAutokepObject:(Autokep *)value;
- (void)removeAutokepObject:(Autokep *)value;
- (void)addAutokep:(NSSet *)values;
- (void)removeAutokep:(NSSet *)values;

@end
