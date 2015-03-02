//
//  VenueCategory.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Venue;

@interface VenueCategory : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * iconPrefix;
@property (nonatomic, retain) NSString * iconSuffix;
@property (nonatomic, retain) NSSet *venues;

@property (nonatomic, readonly, strong) NSURL *iconURL;

@end
