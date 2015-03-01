//
//  NSFetchedResultsController+ETRUtils.m
//
//  Created by Vadim Yelagin on 15/10/14.
//  Copyright (c) 2014 EastBanc Technologies Russia. All rights reserved.
//

#import "NSFetchedResultsController+ETRUtils.h"

@implementation NSFetchedResultsController (ETRUtils)

- (NSString *)modelIdentifierForElementAtIndexPath:(NSIndexPath *)indexPath
                                            inView:(UIView *)view
{
    if (!indexPath)
        return nil;
    NSManagedObject* mo = [self objectAtIndexPath:indexPath];
    return mo.objectID.URIRepresentation.absoluteString;
}

- (NSIndexPath *)indexPathForElementWithModelIdentifier:(NSString *)identifier
                                                 inView:(UIView *)view
{
    if (!identifier)
        return nil;
    for (NSManagedObject* mo in self.fetchedObjects) {
        if ([mo.objectID.URIRepresentation.absoluteString isEqualToString:identifier]) {
            return [self indexPathForObject:mo];
        }
    }
    return nil;
}

@end
