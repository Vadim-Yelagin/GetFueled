//
//  MapCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "Fueled.h"
#import "MapCell.h"
#import "MapCellModel.h"
#import <MapKit/MapKit.h>

@interface MapCell () <MKMapViewDelegate>

@property (nonatomic, strong) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) MKPointAnnotation *fueledAnnotation;

@end

@implementation MapCell

- (MKPointAnnotation *)fueledAnnotation
{
    if (!_fueledAnnotation) {
        _fueledAnnotation = [[MKPointAnnotation alloc] init];
        CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(FueledLatitude, FueledLongitude);
        _fueledAnnotation.coordinate = coord;
    }
    return _fueledAnnotation;
}

- (void)setViewModel:(MapCellModel *)viewModel
{
    [super setViewModel:viewModel];
    [self.mapView removeAnnotations:self.mapView.annotations];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(viewModel.latitude, viewModel.longitude);
    annotation.coordinate = coord;
    [self.mapView addAnnotation:annotation];
    [self.mapView addAnnotation:self.fueledAnnotation];
    [self.mapView showAnnotations:self.mapView.annotations
                         animated:NO];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView
            viewForAnnotation:(id<MKAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MKUserLocation class]])
        return nil;
    MKAnnotationView* pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:nil];
    pinView.image = (annotation == self.fueledAnnotation)
                  ? [UIImage imageNamed:@"fueledAnnotation"]
                  : [UIImage imageNamed:@"venueAnnotation"];
    pinView.centerOffset = CGPointMake(0, -pinView.image.size.height/2);
    return pinView;
}

@end
