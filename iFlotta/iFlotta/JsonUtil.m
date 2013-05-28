//
//  JsonUtil.m
//  iFlott
//
//  Created by Csüti on 5/10/13.
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "JsonUtil.h"
#import "Sofor.h"



@implementation JsonUtil
+(NSDictionary*)dictionaryWithContentsOfJSONURLString:(NSString*)urlAddress
{
    NSData* data = [NSData dataWithContentsOfURL:
                    [NSURL URLWithString: urlAddress] ];
    
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+(void)JsonSender:(NSMutableDictionary*) jsonStringSend
{
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonStringSend options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://www.flotta.host-ed.me/index33.php"]];
    
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        NSLog(@"Válasz");
    }
    
}

+(void)JsonBuilderSender:(NSArray*) senderObject : (NSString*) objectTipus {
    
    NSMutableDictionary* object = [[NSMutableDictionary alloc] init];
    
    if ([objectTipus isEqualToString:@"Sofor"])
    {
        NSManagedObject *aktsofor = [senderObject objectAtIndex:0];
        
        [object setObject:[aktsofor valueForKey:@"soforPass"] forKey:@"soforPass"];
        [object setObject:[aktsofor valueForKey:@"soforNev"] forKey:@"soforNev"];
        [object setObject:[aktsofor valueForKey:@"soforID"] forKey:@"soforId"];
        [object setObject:[aktsofor valueForKey:@"soforCim"] forKey:@"soforCim"];
        [object setObject:[aktsofor valueForKey:@"soforLogin"] forKey:@"soforLogin"];
        [object setObject:[aktsofor valueForKey:@"soforRegTime"] forKey:@"soforRegTime"];
        [object setObject:[aktsofor valueForKey:@"soforBirthDate"] forKey:@"soforBirthDate"];
        [object setObject:[aktsofor valueForKey:@"soforEmail"] forKey:@"soforEmail"];
        [object setObject:[aktsofor valueForKey:@"soforTelefonszam"] forKey:@"soforTelefonszam"];
        [object setObject:[aktsofor valueForKey:@"soforIsAdmin"] forKey:@"soforIsAdmin"];
        [object setObject:[aktsofor valueForKey:@"soforProfilKepId"] forKey:@"soforProfilKepID"];
        [object setObject:[aktsofor valueForKey:@"soforIsActive"] forKey:@"soforIsActive"];
    }
    
    NSMutableDictionary* json = [[NSMutableDictionary alloc] init];
    
    
    [json setObject:object forKey:@"objects"];
    [json setObject:@"insert" forKey:@"action"];
    [json setObject:@"sofor" forKey:@"tableName"];
    
    NSMutableDictionary* jsonv = [[NSMutableDictionary alloc] init];
    [jsonv setObject:json forKey:@"json"];
    
    [self JsonSender:jsonv];
}

// Ez nem kell majd
+(void)getJson {
    
    NSMutableDictionary* object = [[NSMutableDictionary alloc] init];
    
    [object setObject:@"iOS" forKey:@"soforPass"];
    [object setObject:@"iOS" forKey:@"soforNev"];
    //[object setObject:@"3555" forKey:@"soforId"];
    [object setObject:@"iOS" forKey:@"soforCim"];
    [object setObject:@"iOS" forKey:@"soforLogin"];
    [object setObject:@"iOS" forKey:@"soforRegTime"];
    [object setObject:@"iOS" forKey:@"soforBirthDate"];
    [object setObject:@"iOS" forKey:@"soforEmail"];
    [object setObject:@"iOS" forKey:@"soforTelefonszam"];
    [object setObject:@"1" forKey:@"soforIsAdmin"];
    [object setObject:@"2" forKey:@"soforProfilKepID"];
    [object setObject:@"1" forKey:@"soforIsActive"];
    
    NSMutableDictionary* json = [[NSMutableDictionary alloc] init];
    

    [json setObject:object forKey:@"objects"];
    [json setObject:@"insert" forKey:@"action"];
    [json setObject:@"sofor" forKey:@"tableName"];
    
    NSMutableDictionary* jsonv = [[NSMutableDictionary alloc] init];
    [jsonv setObject:json forKey:@"json"];
    
    
    NSError* error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonv options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://www.flotta.host-ed.me/index33.php"]];
    
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    if (connection) {
        NSLog(@"Válasz");
    }
}
@end
