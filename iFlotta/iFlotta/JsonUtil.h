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
    +(NSData*)toJSON;
@end
