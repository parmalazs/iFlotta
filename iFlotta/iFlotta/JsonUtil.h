//
//  JsonUtil.h
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JsonUtil : NSObject
    +(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress;
    +(void)getJson;
    +(void)JsonBuilderSender:(NSArray*) senderObject : (NSString*) objectTipus :(NSString*) actionTipus;
    +(void)JsonSender:(NSMutableDictionary*) jsonStringSend;
@end
