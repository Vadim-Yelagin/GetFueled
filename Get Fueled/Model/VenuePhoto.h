//
//  VenuePhoto.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 02/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class VenuePhotosGroup;

@interface VenuePhoto : NSManagedObject

@property (nonatomic, retain) NSString * prefix;
@property (nonatomic, retain) NSString * suffix;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) VenuePhotosGroup *group;

@end
