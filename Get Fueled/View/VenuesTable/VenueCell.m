//
//  VenueCell.m
//  Get Fueled
//
//  Created by Vadim Yelagin on 01/03/15.
//  Copyright (c) 2015 Fueled. All rights reserved.
//

#import "FoursquareService.h"
#import "Venue.h"
#import "VenueCategory.h"
#import "VenueCell.h"
#import <ETRUtils/ETRUtils.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <RestKit/RestKit.h>

@interface VenueCell ()

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) IBOutlet UILabel *ratingLabel;
@property (nonatomic, strong) IBOutlet UILabel *isOpenLabel;
@property (nonatomic, strong) IBOutlet UILabel *categoriesLabel;
@property (nonatomic, strong) IBOutlet UIImageView *categoryIcon;

@end

@implementation VenueCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(updateViews)
               name:NSManagedObjectContextDidSaveNotification
             object:[FoursquareService sharedService].mainMOC];
}

- (void)dealloc
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self
                  name:NSManagedObjectContextDidSaveNotification
                object:[FoursquareService sharedService].mainMOC];
}

- (void)setViewModel:(Venue *)viewModel
{
    [super setViewModel:viewModel];
    [self updateViews];
}

- (void)updateViews
{
    if (!self.viewModel)
        return;
    self.nameLabel.text = self.viewModel.name;
    NSNumberFormatter *nf = [[NSNumberFormatter alloc] init];
    nf.numberStyle = NSNumberFormatterDecimalStyle;
    nf.usesSignificantDigits = YES;
    nf.minimumSignificantDigits = 2;
    nf.maximumSignificantDigits = 2;
    self.ratingLabel.text = [nf stringFromNumber:@(self.viewModel.rating)];
    self.ratingLabel.textColor = [UIColor etr_colorWithHexString:self.viewModel.ratingColor];
    self.isOpenLabel.text = self.viewModel.isOpenStatus;
    self.isOpenLabel.textColor = self.viewModel.isOpen ? [UIColor blackColor] : [UIColor redColor];
    NSArray *sortedCategories = [self.viewModel.categories sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]]];
    NSArray *sortedNames = [sortedCategories etr_map:^NSString *(VenueCategory *obj) { return obj.name; }];
    self.categoriesLabel.text = [sortedNames componentsJoinedByString:@", "];
    VenueCategory *category = self.viewModel.categories.anyObject;
    UIImage *placeholderIcon = [UIImage imageNamed:@"categoryPlaceholder"];
    [self.categoryIcon setImageWithURL:category.iconURL
                      placeholderImage:placeholderIcon];
}

+ (NSString *)reuseIdentifier
{
    return @"VenueCell";
}

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"VenueCell"
                          bundle:nil];
}

+ (CGFloat)heightForViewModel:(Venue *)viewModel
                  inTableView:(UITableView *)tableView
{
    static VenueCell *prototype = nil;
    if (!prototype) {
        prototype = [[self nib] instantiateWithOwner:nil options:nil].firstObject;
    }
    UILabel *label = prototype.nameLabel;
    label.text = viewModel.name;
    CGFloat xPadding = prototype.bounds.size.width - label.bounds.size.width;
    CGFloat yPadding = prototype.bounds.size.height - label.bounds.size.height;
    CGFloat labelWidth = tableView.bounds.size.width - xPadding;
    CGFloat labelHeight = [label sizeThatFits:CGSizeMake(labelWidth, 9999)].height;
    return labelHeight + yPadding;
}

@end
