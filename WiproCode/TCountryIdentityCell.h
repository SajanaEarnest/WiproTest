//
//  TCountryIdentityCell.h
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface TCoutryIdentityCell : UITableViewCell

@property (nonatomic, weak) UIImageView *referenceImageView;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *descriptionLabel;

@end

extern CGFloat getSpacingBetweenItems();
extern CGFloat getReferenceImageViewWidth();
extern CGFloat getTotalVerticalSpacing();
extern CGFloat getTotalHorizontalSpacing();
extern CGFloat getMinimumCellHeight();
extern CGFloat getLabelWidth();
extern UIFont *getTitleFont();
extern UIFont *getDescriptionFont();
