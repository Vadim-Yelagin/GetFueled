//
//  VenuesTableViewModel.h
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "ETRFetchedResultsCollectionModel.h"

@class RACCommand;

@interface VenuesTableViewModel : ETRFetchedResultsCollectionModel

@property (nonatomic, readonly, strong) RACCommand *refreshCommand;

@end
