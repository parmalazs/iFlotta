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

@interface MapViewController () {
    NSArray* _partnerek;
    NSArray* _telephelyek;
    NSArray* _autok;
    NSArray* _munka;
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
    
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    
    
   _telephelyek = [DataBaseUtil fetchRequest:@"Telephely" :@"1" :@"telephelyIsActive"];
    _partnerek =[DataBaseUtil fetchRequest:@"Partner" :@"1" :@"partnerIsActive"];
    _autok = [DataBaseUtil fetchRequest:@"Auto" :@"1" :@"autoIsActive"];
   // _munka = [Data]
    
    for(Telephely *t in _telephelyek)
    {
        
        
        
        CLLocationCoordinate2D  ctrpoint;
        ctrpoint.latitude =  [[t telephelyXkoordinata] doubleValue];
        ctrpoint.longitude = [[t telephelyYkoordinata] doubleValue];
        AddressAnnotation *addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:ctrpoint];
        
        [addAnnotation setTitle:t.telephelyNev];
        [addAnnotation setSubtitle:t.telephelyTelefonszam];
        
        [self.mapView addAnnotation:addAnnotation];
        
 
    }
    
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
    MKCoordinateRegion mapRegion;
    mapRegion.center = mapView.userLocation.coordinate;
    mapRegion.span.latitudeDelta = 0.2;
    mapRegion.span.longitudeDelta = 0.2;
    
    [mapView setRegion:mapRegion animated: YES];
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
   /* for(MKAnnotationView *annotationView in views) {
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
    }*/
}	


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *identifier = @"MyLocation";
    
        
        MKAnnotationView *annotationView = (MKAnnotationView *) [_mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            annotationView.enabled = YES;
            annotationView.canShowCallout = YES;
            //annotationView.
            annotationView.image = [UIImage imageNamed:@"arrest.png"];//here we use a nice image instead of the default pins
        } else {
            annotationView.annotation = annotation;
        }
        
        return annotationView;
    
    
    
}

- (void)didSelectItem:(NSDictionary *)item{
    NSLog(@"%@",item);
    [dropdown dismiss];
}

@end
