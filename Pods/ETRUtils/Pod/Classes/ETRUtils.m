//
//  ETRUtils.m
//
//  Created by Vadim Yelagin on 28/10/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

#import "ETRUtils.h"

NSString* NSStringFromNSIndexPath(NSIndexPath* indexPath)
{
    NSMutableArray* indices = [NSMutableArray array];
    for (NSInteger i = 0; i < indexPath.length; i++) {
        NSUInteger index = [indexPath indexAtPosition:i];
        [indices addObject:@(index).stringValue];
    }
    return [indices componentsJoinedByString:@"/"];
}

NSIndexPath* NSIndexPathFromNSString(NSString* string)
{
    NSArray* indices = [string componentsSeparatedByString:@"/"];
    NSUInteger* uhoh = malloc(sizeof(NSUInteger) * indices.count);
    NSInteger i = 0;
    for (NSString* index in indices) {
        uhoh[i++] = [index integerValue];
    }
    NSIndexPath* res = [NSIndexPath indexPathWithIndexes:uhoh length:indices.count];
    free(uhoh); uhoh = NULL;
    return res;
}

@implementation ETRUtils

+ (BOOL)isOS7
{
    static BOOL res = NO;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        res = ([[UIDevice currentDevice].systemVersion compare:@"7" options:NSNumericSearch] != NSOrderedAscending);
    });
    return res;
}

+ (BOOL)isIpad {
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (NSURL *)applicationCachesDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

+ (NSString *)russianPluralForQuantity:(NSInteger)quantity
                                single:(NSString *)singleForm
                                   few:(NSString *)fewForm
                                  many:(NSString *)manyForm
{
    if (quantity < 0)
        quantity = -quantity;
    quantity %= 100;
    if (5 <= quantity && quantity <= 20)
        return manyForm;
    quantity %= 10;
    if (quantity == 1)
        return singleForm;
    if (2 <= quantity && quantity <= 4)
        return fewForm;
    return manyForm;
}

+ (NSString *)russianQuantityWithPlural:(NSInteger)quantity
                                 single:(NSString *)singleForm
                                    few:(NSString *)fewForm
                                   many:(NSString *)manyForm
{
    NSString* plural = [self russianPluralForQuantity:quantity
                                               single:singleForm
                                                  few:fewForm
                                                 many:manyForm];
    return [NSString stringWithFormat:@"%@ %@", @(quantity), plural];
}

@end
