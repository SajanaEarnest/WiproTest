//
//  TCountryIdentityCell.m
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//


#import "TCountryIdentityCell.h"


CGFloat getBackgroundViewPadding() {
    return 4.0;
}

@interface TCoutryIdentityCell()


@property (nonatomic, weak) UIView *backgroundView;
@end

@implementation TCoutryIdentityCell

@synthesize backgroundView = _backgroundView;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    //
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        //
        [self _addbackgroundView];
        [self _addTitleLabel];
        [self _addReferenceImageView];
        [self _addDescriptionLabel];
        //
        [self _setUpAutolayoutForReferenceImageView];
        [self _setUpAutolayoutForTitleLabel];
        [self _setUpAutolayoutForBackgroundView];
        [self _setUpAutolayoutForDescriptionLabel];
    }
    //
    return self;
}

-(void)_addbackgroundView {
    //
    UIView *backgroundView  = [[UIView alloc]init];
    backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:backgroundView];
    //
    backgroundView.backgroundColor = [UIColor whiteColor];
    backgroundView.layer.masksToBounds = NO;
    backgroundView.layer.cornerRadius = 3.0;
    backgroundView.layer.shadowOffset = CGSizeMake(3.0, 2.0);
    backgroundView.layer.shadowRadius = 5;
    backgroundView.layer.shadowOpacity = 0.5;
    //
    self.backgroundView = backgroundView;
}

-(void)_addTitleLabel {
    //
    UILabel *titleLabel = [[UILabel alloc]init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.numberOfLines = 0;
    titleLabel.font = getTitleFont();
    titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor blackColor];
    [titleLabel setContentHuggingPriority:252 forAxis:UILayoutConstraintAxisVertical];
    //
    [self.contentView addSubview:titleLabel];
    self.titleLabel = titleLabel;
    //
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    
    visualEffectView.frame = titleLabel.bounds;
    [titleLabel addSubview:visualEffectView];
}

-(void)_addReferenceImageView {
    //
    UIImageView *imageView  = [[UIImageView alloc]init];
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.backgroundColor = [UIColor lightGrayColor];
    //
    [self.contentView addSubview:imageView];
    self.referenceImageView = imageView;
}

-(void)_addDescriptionLabel {
    //
    UILabel *descriptionLabel = [[UILabel alloc]init];
    descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    descriptionLabel.numberOfLines = 0;
    descriptionLabel.font = getDescriptionFont();
    descriptionLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descriptionLabel.backgroundColor = [UIColor whiteColor];
    [descriptionLabel setContentHuggingPriority:251 forAxis:UILayoutConstraintAxisVertical];
    //
    [self.contentView addSubview:descriptionLabel];
    
    self.descriptionLabel = descriptionLabel;
}

-(void)_setUpAutolayoutForBackgroundView {
    //
    UIView *parentItem = self.contentView;
    UIView *currentItem = _backgroundView;
    //
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentItem attribute:NSLayoutAttributeLeading multiplier:1.0f constant:getBackgroundViewPadding()];
    //
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:parentItem attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:currentItem attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:getBackgroundViewPadding()];
    //
    NSLayoutConstraint *top =[NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentItem attribute:NSLayoutAttributeTop multiplier:1.0f constant:getBackgroundViewPadding()];
    //
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:parentItem attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:currentItem attribute:NSLayoutAttributeBottom multiplier:1.0f constant:getBackgroundViewPadding()];
    
    [parentItem addConstraint:leading];
    [parentItem addConstraint:trailing];
    [parentItem addConstraint:top];
    [parentItem addConstraint:bottom];
}

-(UILabel *)_setUpAutolayoutForTitleLabel {
    //
    UIView *parentItem = self.contentView;
    UILabel *currentItem = _titleLabel;
    //
    NSLayoutConstraint *top =[NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:parentItem attribute:NSLayoutAttributeTop multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentItem attribute:NSLayoutAttributeLeading multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:parentItem attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:currentItem attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    [parentItem addConstraint:top];
    [parentItem addConstraint:leading];
    [parentItem addConstraint:trailing];
    //
    return _titleLabel;
}


-(void)_setUpAutolayoutForReferenceImageView {
    //
    UIView *parentItem = self.contentView;
    UIImageView *currentItem = _referenceImageView;
    UIView *topItem = _titleLabel;
    //
    NSLayoutConstraint *top =[NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topItem attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0];
    //
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentItem attribute:NSLayoutAttributeLeading multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:parentItem attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:currentItem attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    [parentItem addConstraint:top];
    [parentItem addConstraint:leading];
    [parentItem addConstraint:trailing];
}

-(void)_setUpAutolayoutForDescriptionLabel {
    //
    UIView *parentItem = self.contentView;
    UIView *topItem = _referenceImageView;
    UILabel *currentItem = _descriptionLabel;
    //
    NSLayoutConstraint *leading = [NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:parentItem attribute:NSLayoutAttributeLeading multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    NSLayoutConstraint *trailing = [NSLayoutConstraint constraintWithItem:parentItem attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:currentItem attribute:NSLayoutAttributeTrailing multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    NSLayoutConstraint *top =[NSLayoutConstraint constraintWithItem:currentItem attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:topItem attribute:NSLayoutAttributeBottom multiplier:1.0f constant:getSpacingBetweenItems()];
    //
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:parentItem attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:currentItem attribute:NSLayoutAttributeBottom multiplier:1.0f constant:getSpacingBetweenItems()];
    
    [parentItem addConstraint:leading];
    [parentItem addConstraint:trailing];
    [parentItem addConstraint:top];
    [parentItem addConstraint:bottom];
}


@end

CGFloat getSpacingBetweenItems() {
    //
    return 8.0;
}

CGFloat getScreenWidth() {
    //
    CGRect windowFrame = [[[UIApplication sharedApplication] keyWindow] frame];
    //
    return windowFrame.size.width;
}

CGFloat getReferenceImageViewWidth () {
    return getScreenWidth() - (2 * getSpacingBetweenItems());
}


CGFloat getTotalVerticalSpacing() {
    return getSpacingBetweenItems() * 3;
}


CGFloat getTotalHorizontalSpacing() {
    return getSpacingBetweenItems() *3;
}

CGFloat getMinimumCellHeight() {
    return 0.0;
}

CGFloat getLabelWidth() {
    //
    return getScreenWidth() - (2 * getSpacingBetweenItems());
}

UIFont *getTitleFont() {
    return [UIFont boldSystemFontOfSize:18.0];
}

UIFont *getDescriptionFont() {
    return [UIFont systemFontOfSize:14.0];
}
