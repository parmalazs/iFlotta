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
    
    [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL
                                                 URLWithString:@"http://www.flotta.host-ed.me/index33.php"]];
    
    NSData *requestData = [NSData dataWithBytes:[jsonString UTF8String] length:[jsonString length]];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%d", [requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    
    //NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    NSURLResponse *theResponse =[[NSURLResponse alloc]init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&theResponse error:&error];
    //[request setHTTPBody:data];
    NSLog(@"Válasz1: %@", data);
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Válasz2: %@", string);
}

+(void)JsonBuilderSender:(NSArray*) senderObject : (NSString*) objectTipus :(NSString*) actionTipus {
    
    NSMutableDictionary* object = [[NSMutableDictionary alloc] init];
    NSMutableDictionary* json = [[NSMutableDictionary alloc] init];
    [json setObject:object forKey:@"objects"];
    
    if ([objectTipus isEqualToString:@"Sofor"])
    {
        NSManagedObject *aktsofor = [senderObject objectAtIndex:0];
        
        /*
        if ([actionTipus isEqualToString:@"update"])
        {
            [json setObject:[aktsofor valueForKey:@"soforID"] forKey:@"id"];
        }*/
        
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
        
        [json setObject:@"sofor" forKey:@"tableName"];
    }
    
    if ([objectTipus isEqualToString:@"Auto"])
    {
        NSManagedObject *aktauto = [senderObject objectAtIndex:0];
        
        if ([actionTipus isEqualToString:@"update"])
        {
            [object setObject:[aktauto valueForKey:@"autoID"] forKey:@"autoId"];
            [object setObject:[aktauto valueForKey:@"autoFoglalt"] forKey:@"autoFoglalt"];
            [object setObject:[aktauto valueForKey:@"autoNev"] forKey:@"autoNev"];
            [object setObject:[aktauto valueForKey:@"autoIsActive"] forKey:@"autoIsActive"];
            [object setObject:[aktauto valueForKey:@"autoLastSoforID"] forKey:@"autoLastSoforID"];
            [object setObject:[aktauto valueForKey:@"autoRendszam"] forKey:@"autoRendszam"];
            //[object setObject:@"autoTipusssss" forKey:@"autoTipus"];
            //[object setObject:[aktauto valueForKey:@"autoKilometerOra"] forKey:@"autoKilometerOra"];
            //[object setObject:[aktauto valueForKey:@"autoLastTelephelyID"] forKey:@"autoLastTelephelyID"];
            //[object setObject:[aktauto valueForKey:@"autoUzemAnyag"] forKey:@"autoUzemAnyag"];
            //[object setObject:[aktauto valueForKey:@"autoLastSzervizDate"] forKey:@"autoLastSzervizDate"];
            //[object setObject:[aktauto valueForKey:@"autoLastUpDate"] forKey:@"autoLastUpDate"];
            //[object setObject:[aktauto valueForKey:@"autoMuszakiVizsgaDate"] forKey:@"autoMuszakiVizsgaDate"];
            //[object setObject:[aktauto valueForKey:@"autoProfilKepID"] forKey:@"autoProfilKepID"];
            //[object setObject:[aktauto valueForKey:@"autoXkoordinata"] forKey:@"autoXkoordinata"];
            //[object setObject:[aktauto valueForKey:@"autoYkoordinata"] forKey:@"autoYkoordinata"];
        }
        else
        {
            [object setObject:[aktauto valueForKey:@"autoID"] forKey:@"autoId"];
            [object setObject:[aktauto valueForKey:@"autoNev"] forKey:@"autoNev"];
            [object setObject:[aktauto valueForKey:@"autoIsActive"] forKey:@"autoIsActive"];
            [object setObject:[aktauto valueForKey:@"autoFoglalt"] forKey:@"autoFoglalt"];
            [object setObject:[aktauto valueForKey:@"autoLastSoforID"] forKey:@"autoLastSoforID"];
            [object setObject:[aktauto valueForKey:@"autoRendszam"] forKey:@"autoRendszam"];
            [object setObject:[aktauto valueForKey:@"autoTipus"] forKey:@"autoTipus"];
            [object setObject:[aktauto valueForKey:@"autoKilometerOra"] forKey:@"autoKilometerOra"];
            [object setObject:[aktauto valueForKey:@"autoLastTelephelyID"] forKey:@"autoLastTelephelyID"];
            [object setObject:[aktauto valueForKey:@"autoUzemAnyag"] forKey:@"autoUzemAnyag"];
            [object setObject:[aktauto valueForKey:@"autoLastSzervizDate"] forKey:@"autoLastSzervizDate"];
            [object setObject:[aktauto valueForKey:@"autoLastUpDate"] forKey:@"autoLastUpDate"];
            [object setObject:[aktauto valueForKey:@"autoMuszakiVizsgaDate"] forKey:@"autoMuszakiVizsgaDate"];
            [object setObject:[aktauto valueForKey:@"autoProfilKepID"] forKey:@"autoProfilKepID"];
            [object setObject:[aktauto valueForKey:@"autoXkoordinata"] forKey:@"autoXkoordinata"];
            [object setObject:[aktauto valueForKey:@"autoYkoordinata"] forKey:@"autoYkoordinata"];
        }
        

        
        [json setObject:@"auto" forKey:@"tableName"];
    }
        
    if ([objectTipus isEqualToString:@"Munka"])
    {
        NSLog(@"MunkaInsert");
        //NSLog(@"ADATOK KÜLDÉSHEZ: %@",[senderObject objectAtIndex:0]);
        NSManagedObject *aktMunka = [senderObject objectAtIndex:0];
        
        [object setObject:[aktMunka valueForKey:@"munkaBefejezesDate"] forKey:@"munkaBefejezesDate"];
        [object setObject:[aktMunka valueForKey:@"munkaBevetel"] forKey:@"munkaBevetel"];
        [object setObject:[aktMunka valueForKey:@"munkaComment"] forKey:@"munkaComment"];
        [object setObject:[aktMunka valueForKey:@"munkaDate"] forKey:@"munkaDate"];
        [object setObject:[aktMunka valueForKey:@"munkaEstimatedTime"] forKey:@"munkaEstimatedTime"];
        [object setObject:[aktMunka valueForKey:@"munkaID"] forKey:@"munkaId"];
        [object setObject:[aktMunka valueForKey:@"munkaIsActive"] forKey:@"munkaIsActive"];
        [object setObject:[aktMunka valueForKey:@"munkaKoltseg"] forKey:@"munkaKoltseg"];
        [object setObject:[aktMunka valueForKey:@"munkatipusID"] forKey:@"munkatipusID"];
        [object setObject:[aktMunka valueForKey:@"munkaUzemanyagState"] forKey:@"munkaUzemanyagState"];
        [object setObject:[aktMunka valueForKey:@"partnerID"] forKey:@"partnerID"];
        [object setObject:[aktMunka valueForKey:@"soforID"] forKey:@"soforID"];
        [object setObject:[aktMunka valueForKey:@"telephelyID"] forKey:@"telephelyID"];
        
        [json setObject:@"munka" forKey:@"tableName"];
    }
    if ([objectTipus isEqualToString:@"Telephely"])
    {
        //NSLog(@"TelephelyInsert");
        //NSLog(@"ADATOK KÜLDÉSHEZ: %@",[senderObject objectAtIndex:0]);
        NSManagedObject *aktTelephely = [senderObject objectAtIndex:0];
        
        [object setObject:[aktTelephely valueForKey:@"telephelyCim"] forKey:@"telephelyCim"];
        [object setObject:[aktTelephely valueForKey:@"telephelyEmail"] forKey:@"telephelyEmail"];
        [object setObject:[aktTelephely valueForKey:@"telephelyID"] forKey:@"telephelyId"];
        [object setObject:[aktTelephely valueForKey:@"telephelyNev"] forKey:@"telephelyNev"];
        [object setObject:[aktTelephely valueForKey:@"telephelyTelefonszam"] forKey:@"telephelyTelefonszam"];
        [object setObject:[aktTelephely valueForKey:@"telephelyXkoordinata"] forKey:@"telephelyXkoordinata"];
        [object setObject:[aktTelephely valueForKey:@"telephelyYkoordinata"] forKey:@"telephelyYkoordinata"];
        [object setObject:[aktTelephely valueForKey:@"telephelyIsActive"] forKey:@"telephelyIsActive"];
        
        [json setObject:@"telephely" forKey:@"tableName"];
    }
    if ([objectTipus isEqualToString:@"Partner"])
    {
        //NSLog(@"PartnerInsert");
        //NSLog(@"ADATOK KÜLDÉSHEZ: %@",[senderObject objectAtIndex:0]);
        NSManagedObject *aktPartner = [senderObject objectAtIndex:0];
        
        [object setObject:[aktPartner valueForKey:@"partnerCim"] forKey:@"partnerCim"];
        [object setObject:[aktPartner valueForKey:@"partnerEmailcim"] forKey:@"partnerEmailcim"];
        [object setObject:[aktPartner valueForKey:@"partnerID"] forKey:@"partnerId"];
        [object setObject:[aktPartner valueForKey:@"partnerNev"] forKey:@"partnerNev"];
        [object setObject:[aktPartner valueForKey:@"partnerTelefonszam"] forKey:@"partnerTelefonszam"];
        [object setObject:[aktPartner valueForKey:@"partnerWeboldal"] forKey:@"partnerWeboldal"];
        [object setObject:[aktPartner valueForKey:@"partnerXkoordinata"] forKey:@"partnerXkoordinata"];
        [object setObject:[aktPartner valueForKey:@"partnerYkoordinata"] forKey:@"partnerYkoordinata"];
        [object setObject:[aktPartner valueForKey:@"partnerIsActive"] forKey:@"partnerIsActive"];
        
        [json setObject:@"partner" forKey:@"tableName"];
    }
    
    if ([actionTipus isEqualToString:@"insert"])
    {
        [json setObject:@"insert" forKey:@"action"];
    }
    else
    {
        [json setObject:@"update" forKey:@"action"];
    }
    
    
    NSMutableDictionary* jsonv = [[NSMutableDictionary alloc] init];
    [jsonv setObject:json forKey:@"json"];
    
    [self JsonSender:jsonv];
}
@end
