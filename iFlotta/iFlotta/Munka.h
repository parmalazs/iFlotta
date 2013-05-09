//
//  Munka.h
//  iFlotta
//
//  Created by Csüti on 5/9/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Munkaeszkoz, Munkakep, Munkatipus, Partner, Sofor, Telephely;

@interface Munka : NSManagedObject

@property (nonatomic, retain) NSString * munkaBefejezesDate;
@property (nonatomic, retain) NSNumber * munkaBevetel;
@property (nonatomic, retain) NSString * munkaComment;
@property (nonatomic, retain) NSString * munkaDate;
@property (nonatomic, retain) NSString * munkaEstimatedTime;
@property (nonatomic, retain) NSNumber * munkaID;
@property (nonatomic, retain) NSNumber * munkaIsActive;
@property (nonatomic, retain) NSNumber * munkaKoltseg;
@property (nonatomic, retain) NSNumber * munkatipusID;
@property (nonatomic, retain) NSNumber * munkaUzemanyagState;
@property (nonatomic, retain) NSNumber * partnerID;
@property (nonatomic, retain) NSNumber * soforID;
@property (nonatomic, retain) NSNumber * telephelyID;
@property (nonatomic, retain) NSSet *munkaeszkoz;
@property (nonatomic, retain) NSSet *munkakep;
@property (nonatomic, retain) Munkatipus *munkatipus;
@property (nonatomic, retain) Partner *partner;
@property (nonatomic, retain) Sofor *sofor;
@property (nonatomic, retain) Telephely *telephely;
@end

@interface Munka (CoreDataGeneratedAccessors)

- (void)addMunkaeszkozObject:(Munkaeszkoz *)value;
- (void)removeMunkaeszkozObject:(Munkaeszkoz *)value;
- (void)addMunkaeszkoz:(NSSet *)values;
- (void)removeMunkaeszkoz:(NSSet *)values;

- (void)addMunkakepObject:(Munkakep *)value;
- (void)removeMunkakepObject:(Munkakep *)value;
- (void)addMunkakep:(NSSet *)values;
- (void)removeMunkakep:(NSSet *)values;

@end
