//
//  MapViewController.m
//  iFlott
//
//  Created by hallgato2 on 2013.05.29..
//  Copyright (c) 2013 Csüti. All rights reserved.
//

#import "MapViewController.h"
#import "DataBaseUtil.h"
#import "Telephely.h"
#import "AddressAnnotation.h"
#import "Auto.h"
#import "Partner.h"
#import "Munka.h"
#import "MapPinAnnotation.h"

@interface MapViewController () {
    NSArray* _partnerek;
    NSArray* _telephelyek;
    NSArray* _autok;
    NSArray* _munka;
    NSMutableArray* _flottaAnnotations;
}

@end



@implementation MapViewController

@synthesize mapView = _mapView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    _flottaAnnotations = [[NSMutableArray alloc]init];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    
       
     dropdown = [[MBDropdown alloc] initWithPresentingView:self.view andItems:@[@{@"name" : @"Autók",@"image" : @"40-inbox.png"},@{@"name" : @"Partnerek",@"image":@"166-newspaper.png"},@{@"name":@"Telephelyek",@"image":@"280-clapboard.png"},@{@"name" : @"Napi útvonal",@"image" : @"40-inbox.png"},@{@"name" : @"Szabad munkák",@"image" : @"40-inbox.png"}] delegate:self kezdpoz:[[NSNumber alloc] initWithInt:0]];
    
    self.navigationItem.rightBarButtonItem = dropdown.barButton;
    
    //[_mapView removeAnnotations:_mapView.annotations];
    
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
   /* MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [mapView setRegion:mapRegion animated: YES];*/
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    for(MKAnnotationView *annotationView in views) {
        if(annotationView.annotation == mv.userLocation) {
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            
            span.latitudeDelta=0.1;
            span.longitudeDelta=0.1;
            
            CLLocationCoordinate2D location=mv.userLocation.coordinate;
            
            region.span=span;
            region.center=location;
            
            [mv setRegion:region animated:TRUE];
            [mv regionThatFits:region];
        }
    }
}	


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    
        
       /* MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            //annotationView.
            annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;*/
    
    if ([annotation isKindOfClass:[MKUserLocation class]])
    {
        return nil;
    }
    
    static NSString* myIdentifier = @"myIndentifier";
    MKPinAnnotationView* pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:myIdentifier];
    
    if (!pinView)
    {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:myIdentifier];
        pinView.pinColor = MKPinAnnotationColorRed;
        pinView.animatesDrop = YES;
        
        pinView.enabled = YES;
        pinView.canShowCallout = YES;
        pinView.image = [UIImage imageNamed:@"arrest.png"];
         return pinView;
    }
    else{
        pinView.annotation = annotation;
        return pinView;
    }
    
    
}

-(void)removeAllAnnotations
{
    //Get the current user location annotation.
    id userAnnotation=_mapView.userLocation;
    
    //Remove all added annotations
    [_mapView removeAnnotations:self.mapView.annotations];
    
    // Add the current user location annotation again.
    if(userAnnotation!=nil)
        [_mapView addAnnotation:userAnnotation];
    
    NSMutableArray *toRemove = [[NSMutableArray alloc]init];
    for (id annotation in _mapView.annotations)
        if (annotation != _mapView.userLocation)
            [toRemove addObject:annotation];
    [_mapView removeAnnotations:toRemove];
    
}

- (void)didSelectItem:(NSDictionary *)item{
    NSLog(@"%@",item);
    
    
    switch ((unsigned long)[[item valueForKey:@"row"] indexAtPosition:1]) {
//autok
        case 0:
            NSLog(@"0");
        {
             //[self removeAllAnnotations];
            
            for(MapPinAnnotation *mp in _flottaAnnotations)
            {
                [self.mapView removeAnnotation:mp];
            }
            
            [_flottaAnnotations removeAllObjects];

            _autok = [DataBaseUtil fetchRequest:@"Auto" :@"1" :@"autoIsActive"];
                      
            for(Auto *a in _autok)
            {
                CLLocationCoordinate2D ctrpoint;
                ctrpoint.latitude = [[a autoXkoordinata] doubleValue];
                ctrpoint.longitude = [[a autoYkoordinata] doubleValue];
                //AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:ctrpoint];
                
                MapPinAnnotation* pinAnnotation =
                [[MapPinAnnotation alloc] initWithCoordinates:ctrpoint
                                                    placeName:a.autoNev
                                                  description:a.autoRendszam];
                
                
                [_flottaAnnotations addObject:pinAnnotation];
                
            }
            
            for(MapPinAnnotation *mp in _flottaAnnotations)
            {
             [self.mapView addAnnotation:mp];
            }
            
            
            for (id annotation in _flottaAnnotations) {
                NSLog(@"%@", _flottaAnnotations);
            }
            

            
        }
            break;   //partnerek
        case 1:
        {
            //[self removeAllAnnotations];
           _partnerek =[DataBaseUtil fetchRequest:@"Partner" :@"1" :@"partnerIsActive"];
          
            
            for(MapPinAnnotation *mp in _flottaAnnotations)
            {
                [self.mapView removeAnnotation:mp];
            }

            [_flottaAnnotations removeAllObjects];

            for(Partner *p in _partnerek)
            {
                CLLocationCoordinate2D ctrpoint;
                ctrpoint.latitude = [[p partnerXkoordinata] doubleValue];
                ctrpoint.longitude = [[p partnerYkoordinata] doubleValue];
                //AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:ctrpoint];
                
                MapPinAnnotation* pinAnnotation =
                [[MapPinAnnotation alloc] initWithCoordinates:ctrpoint
                                                    placeName:p.partnerNev
                                                  description:p.partnerTelefonszam];
              
                
                [_flottaAnnotations addObject:pinAnnotation];
              //  [self.mapView addAnnotation:pinAnnotation];
            }
            
            for(MapPinAnnotation *mp in _flottaAnnotations)
            {
                [self.mapView addAnnotation:mp];
            }

            
            
               NSLog(@"%@", _flottaAnnotations);
            
            
        }
            break; 
            //telephelyek
        case 2:
        {
            //[self removeAllAnnotations];
            
            for(MapPinAnnotation *mp in _flottaAnnotations)
            {
                [self.mapView removeAnnotation:mp];
            }

            [_flottaAnnotations removeAllObjects];

            
            _telephelyek = [DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive"];
            
            
            // _munka = [Data]
            
            for(Telephely *t in _telephelyek)
            {
                
                
                
                CLLocationCoordinate2D  ctrpoint;
                ctrpoint.latitude =  [[t telephelyXkoordinata] doubleValue];
                ctrpoint.longitude = [[t telephelyYkoordinata] doubleValue];
               
                MapPinAnnotation* pinAnnotation =
                [[MapPinAnnotation alloc] initWithCoordinates:ctrpoint
                                                    placeName:t.telephelyNev
                                                  description:t.telephelyTelefonszam];

                
                            
               [_flottaAnnotations addObject:pinAnnotation];
                
                //[self.mapView addAnnotation:pinAnnotation];
                
                
            }
            
            
            for(MapPinAnnotation *mp in _flottaAnnotations)
            {
                [self.mapView addAnnotation:mp];
            }

            
           NSLog(@"%@", _flottaAnnotations);
         
            


        }
            break; 
            //
        case 3:
        {
            
        }
            break; 
    }
    [dropdown dismiss];
}

@end
