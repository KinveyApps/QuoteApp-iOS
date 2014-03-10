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
@property (weak, nonatomic) IBOutlet UILabel *searchCountResultLabel;
@property (nonatomic) NSUInteger *spinnerCount;
@property (nonatomic) BOOL isSearchProcess;
@property (nonatomic) BOOL isNeedRemoveSearchView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tableGridSegmentedControl;


- (void)laodData;

- (void)getDataForItemsFromCache:(BOOL)useCache;        //abstract
- (UIView *)headerForTableView; //abstract
- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath;//abstract
- (void)sendSearchRequestWithString:(NSString *)searchString;//abstract
- (CGFloat)heightForRow;        //abstract
- (CGFloat)heightForHeaderInSection; //abstract
- (void)detailViewForIndex:(NSInteger)index; //abstract
- (NSString *)messageForEmptyItems;
- (NSString *)titleForRefreshControl;
- (void)hideSearchBar;
- (void)updateCell:(UICollectionViewCell *)cell forCollectionViewAtIndexPath:(NSIndexPath *)indexPath;//abstract
- (BOOL)isVisibleTableGridSegmentedControl;//abstract
- (Class)classForCollectionViewCell;//abstract
- (NSString *)reusebleCollectionViewID;//abstract

@end
