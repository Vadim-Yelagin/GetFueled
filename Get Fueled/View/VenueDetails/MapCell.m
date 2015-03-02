//
//  MapCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "MapCell.h"
#import "MapCellModel.h"
#import <MapKit/MapKit.h>

@interface MapCell ()

@property (nonatomic, strong) IBOutlet MKMapView *mapView;

@end

@implementation MapCell

- (void)setViewModel:(MapCellModel *)viewModel
{
    [super setViewModel:viewModel];
    [self.mapView removeAnnotations:self.mapView.annotations];
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(viewModel.latitude, viewModel.longitude);
    annotation.coordinate = coord;
    [self.mapView addAnnotation:annotation];
//    [self.mapView showAnnotations:@[annotation]
//                         animated:NO];
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(coord, 300, 300);
    MKCoordinateRegion adjustedRegion = [self.mapView regionThatFits:viewRegion];
    [self.mapView setRegion:adjustedRegion animated:YES];
}

@end
