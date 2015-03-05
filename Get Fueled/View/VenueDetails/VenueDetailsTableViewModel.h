//
//  VenueDetailsTableViewModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <ETRCollectionModel/ETROuterUnionCollectionModel.h>

@class Venue;

@interface VenueDetailsTableViewModel : ETROuterUnionCollectionModel

@property (nonatomic, readonly, strong) Venue* venue;
@property (nonatomic, readonly, strong) id noContentItem;

- (instancetype)initWithVenue:(Venue *)venue;

@end
