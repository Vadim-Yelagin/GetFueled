//
//  ETRUtils.h
//
//  Created by Vadim Yelagin on 28/10/13.
//  Copyright (c) 2013 EastBanc Technologies Russia. All rights reserved.
//

#import "NSArray+ETRUtils.h"
#import "NSBlockOperation+ETRUtils.h"
#import "NSError+ETRUtils.h"
#import "NSFetchedResultsController+ETRUtils.h"
#import "NSMutableArray+ETRUtils.h"
#import "NSMutableDictionary+ETRUtils.h"
#import "NSMutableSet+ETRUtils.h"
#import "NSMutableString+ETRUtils.h"
#import "NSNumber+ETRUtils.h"
#import "NSString+ETRUtils.h"
#import "NSTimer+ETRUtils.h"
#import "UIActivityIndicatorView+ETRUtils.h"
#import "UICollectionView+ETRUtils.h"
#import "UIColor+ETRUtils.h"
#import "UIImage+ETRUtils.h"
#import "UIRefreshControl+ETRUtils.h"
#import "UITableView+ETRUtils.h"
#import "UITableViewCell+ETRUtils.h"
#import "UIView+ETRUtils.h"
#import "UIViewController+ETRUtils.h"

extern NSString* NSStringFromNSIndexPath(NSIndexPath* indexPath);
extern NSIndexPath* NSIndexPathFromNSString(NSString* string);

@interface ETRUtils : NSObject

+ (BOOL)isOS7;
+ (BOOL)isIpad;
+ (NSURL *)applicationCachesDirectory;
+ (NSURL *)applicationDocumentsDirectory;
+ (NSString*)russianPluralForQuantity:(NSInteger)quantity
                               single:(NSString*)singleForm
                                  few:(NSString*)fewForm
                                 many:(NSString*)manyForm;
+ (NSString*)russianQuantityWithPlural:(NSInteger)quantity
                                single:(NSString*)singleForm
                                   few:(NSString*)fewForm
                                  many:(NSString*)manyForm;

@end
