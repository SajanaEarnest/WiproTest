//
//  TCountryIdentityTVC.m
//  WiproCode
//
//  Created by Sajana Earnest on 25/01/17.
//  Copyright © 2017 Sajana Earnest. All rights reserved.
//

#import "TCountryIdentityTVC.h"
#import "TAPICaller.h"

static NSString *TCountryCellID = @"CellID";

@interface TCountryIdentityTVC ()


@property (nonatomic, strong) TCountry *country;
@end

@implementation TCountryIdentityTVC

- (void)viewDidLoad {
    //
    [super viewDidLoad];
    //
    [self _setUpTableView];
    [self _fetchData];
    [self _registerNotifications];
    [self _setUpRefreshControl];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //
    return _country.identities.count;
}

-(void)_fetchData {
    //
    [self _showActivityIndicator];
    [TAPICaller fetchData];
}

-(void)_setUpTableView {
    //
    [self.tableView registerClass:[TCoutryIdentityCell class] forCellReuseIdentifier:TCountryCellID];
    self.tableView.backgroundColor = [UIColor lightGrayColor];
    self.tableView.separatorColor = [UIColor clearColor];
}

-(void)_setUpRefreshControl {
    //
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor purpleColor];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
}

-(void)_showActivityIndicator {
    //
    self.view.userInteractionEnabled = NO;
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicator.translatesAutoresizingMaskIntoConstraints = NO;
    //
    [self.view addSubview:activityIndicator];
    //
    NSLayoutConstraint *centerX = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0];
    //
    NSLayoutConstraint *centerY = [NSLayoutConstraint constraintWithItem:activityIndicator attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0];
    //
    [self.view addConstraints:@[centerX, centerY]];
    [activityIndicator startAnimating];
    self.activityIndicator = activityIndicator;
}

-(void)_hideActivityIndicator {
    //
    [self.activityIndicator  stopAnimating];
    [self.activityIndicator removeFromSuperview];
    //
    self.view.userInteractionEnabled = YES;
}

-(void)_registerNotifications {
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:TAPICallerDidRefreshed object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:TAPICallerDidReceiveError object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceiveNotification:) name:TCountryDidRefreshIdentity object:nil];
}

-(void)refresh:(UIRefreshControl *)control {
    //
    [self _fetchData];
}

-(void)didReceiveNotification:(NSNotification *)notification {
    //
    dispatch_async(dispatch_get_main_queue(), ^{
        //
        @autoreleasepool {
            //
            [self _hideActivityIndicator];
            [self.refreshControl endRefreshing];
            //
            if ([notification.name isEqualToString:TAPICallerDidRefreshed]) {
                //
                [self _reloadDataWithNewCountry:notification.object];
                return;
            }
            
            if ([notification.name isEqualToString:TCountryDidRefreshIdentity]) {
                //
                TIdentity *identity = notification.object[@"identity"];
                NSNumber *index = notification.object[@"index"];
                //
                [self _reloadIdentity:identity atIndex:[index integerValue]] ;
                return;
            }
            //
            if ([notification.name isEqualToString:TAPICallerDidReceiveError]) {
                //
                [self _handleError:notification.object];
            }
        }
    });
}


-(void)_reloadDataWithNewCountry:(TCountry *)country {
    //
    if (!country) return;
    //
    self.country = country;
    //
    self.navigationItem.title = country.title;
    [self.tableView reloadData];
}

-(void)_reloadIdentity:(TIdentity *)identity atIndex:(NSUInteger)index {
    //
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.tableView beginUpdates];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
}

-(void)_handleError:(NSError *)error {
    //
    // handle Error...
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    TIdentity *identity = _country.identities[indexPath.row];
    //
    TCoutryIdentityCell  *cell = [tableView dequeueReusableCellWithIdentifier:TCountryCellID forIndexPath:indexPath];
    //
    cell.referenceImageView.image = identity.image;
    cell.titleLabel.text = identity.title;
    cell.descriptionLabel.text = identity.descripion;
    //
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    return [self _heightForCellAtIndexPath:indexPath];
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //
    cell.backgroundColor = [UIColor clearColor];
}

-(CGFloat)_heightForCellAtIndexPath:(NSIndexPath *)indexPath {
    //
    const CGFloat labelWidth = getLabelWidth();
    const CGFloat totalSpaces = getTotalVerticalSpacing();
    const CGFloat minimumCellHeight = getMinimumCellHeight();
    //
    CGFloat(^getLabelHeight)(id, id) = ^(NSString *string, UIFont *font) {
        //
        if (!string || string.length < 1) return 0.0;
        //
        CGSize assumedSize = CGSizeMake(labelWidth, CGFLOAT_MAX);
        //
        NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
        
        CGSize boundingBox = [string boundingRectWithSize:assumedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:context].size;
        //
        CGSize finalSize = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
        //
        return finalSize.height;
    };
    
    CGFloat(^getImageHeight)(id, CGFloat) = ^(UIImage *image, CGFloat width) {
        //
        if (!image) return 2.0;
        //
        CGFloat oldWidth = image.size.width;
        CGFloat scaleFactor = width / oldWidth;
        //
        return image.size.height * scaleFactor;
    };
    //
    TIdentity *identity = _country.identities[indexPath.row];
    //
    CGFloat totalCellHeight = getLabelHeight(identity.title, getTitleFont()) + getImageHeight(identity.image, getReferenceImageViewWidth()) + getLabelHeight(identity.descripion, getDescriptionFont()) + totalSpaces;
    //
    if (totalCellHeight < minimumCellHeight) totalCellHeight = minimumCellHeight;
    //
    return totalCellHeight;
}

@end
