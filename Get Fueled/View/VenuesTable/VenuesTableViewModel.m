//
//  VenuesTableViewModel.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "FoursquareService.h"
#import "VenuesTableViewModel.h"
#import <CoreData/CoreData.h>

@implementation VenuesTableViewModel

- (instancetype)init
{
    NSManagedObjectContext *moc = [FoursquareService sharedService].mainMOC;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Venue"];
    // TODO use more appropriate sort
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    return [self initWithFetchRequest:request
                 managedObjectContext:moc
                   sectionNameKeyPath:nil
                            cacheName:nil];
}

@end
