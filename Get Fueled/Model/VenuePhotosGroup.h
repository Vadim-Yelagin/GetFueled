//
//  VenuePhotosGroup.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface VenuePhotosGroup : NSManagedObject

@property (nonatomic, retain) NSSet *items;
@property (nonatomic, retain) Venue *venue;

@end
