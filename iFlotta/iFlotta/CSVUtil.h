//
//  CSVUtil.h
//  iFlott
//
//  Created by  hallgato5 on 2013.05.31..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSVUtil : NSObject
+(NSString*)PartnerToCSV:(NSArray *)firstArray : (NSArray *) secondArray : (NSArray *) thirdArray;
+(NSString*)SoforToCSV:(NSArray *)firstArray : (NSArray *) secondArray : (NSArray *) thirdArray;
@end
