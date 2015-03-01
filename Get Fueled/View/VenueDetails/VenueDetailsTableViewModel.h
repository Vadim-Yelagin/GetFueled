//
//  VenueDetailsTableViewModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRStaticCollectionModel.h"

@class Venue;

@interface VenueDetailsTableViewModel : ETRStaticCollectionModel

@property (nonatomic, readonly, strong) Venue* venue;

- (instancetype)initWithVenue:(Venue *)venue;

@end
