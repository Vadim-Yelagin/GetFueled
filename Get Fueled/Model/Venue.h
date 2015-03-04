//
//  Venue.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Venue : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic) BOOL actual;
@property (nonatomic) BOOL isOpen;
@property (nonatomic, retain) NSString * isOpenStatus;
@property (nonatomic) double distance;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) double rating;
@property (nonatomic, retain) NSString * ratingColor;
@property (nonatomic) BOOL thumbsDown;
@property (nonatomic, retain) NSArray * formattedAddress;
@property (nonatomic, retain) NSSet *reviews;
@property (nonatomic, retain) NSSet *categories;
@property (nonatomic, retain) NSSet *photosGroups;

@end
