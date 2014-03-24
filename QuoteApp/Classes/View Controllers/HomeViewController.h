//
//  HomeViewController.h
//  QuoteApp
//
//  Created by Igor Sapyanik on 5.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeViewController : UIViewController

@property (strong, nonatomic) NSArray *items;
@property (nonatomic) BOOL isSearchProcess;
@property (nonatomic) BOOL isNeedRemoveSearchView;

@property (weak, nonatomic) IBOutlet UILabel *searchCountResultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tableGridSegmentedControl;

@property (nonatomic) NSUInteger *spinnerCount;


- (void)laodData;
- (void)hideSearchBar;

//abstract messages
- (void)getDataForItemsFromCache:(BOOL)useCache;
- (UIView *)headerForTableView;
- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)heightForRow;
- (CGFloat)heightForHeaderInSection;

- (void)sendSearchRequestWithString:(NSString *)searchString;

- (void)detailViewForIndex:(NSInteger)index;
- (NSString *)titleForRefreshControl;

- (NSString *)messageForEmptyItems;
- (BOOL)isVisibleTableGridSegmentedControl;
- (NSString *)titleForView;

- (void)updateCell:(UICollectionViewCell *)cell forCollectionViewAtIndexPath:(NSIndexPath *)indexPath;
- (Class)classForCollectionViewCell;
- (NSString *)reusebleCollectionViewID;

@end
