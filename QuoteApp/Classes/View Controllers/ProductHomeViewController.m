//
//  ProductHomeViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 27.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "ProductHomeViewController.h"
#import "ProductTableViewCell.h"
#import "ProductCollectionViewCell.h"
#import "ProductViewCellForIPhone.h"
#import "NewQuoteViewController.h"
#import "ProductModalViewController.h"

#define HEIGHT_FOR_ROW_FOR_IPHONE 100
#define HEIGHT_FOR_ROW_FOR_IPAD 180
#define HEIGHT_FOR_HEADER_IN_SECTION 0
#define CELL_COLLECTION_VIEW_ID @"Product CV Cell"

@implementation ProductHomeViewController


#pragma mark - Initialisation

- (NSString *)titleForView{
    return LOC(PHVC_TITLE);
}

- (NSString *)titleForRefreshControl{
    return LOC(PHVC_REFRESH_CONTROL_TITLE);
}


#pragma mark - View Life Cycle

- (BOOL)isVisibleTableGridSegmentedControl{
    return NO;
}

- (Class)classForCollectionViewCell{
    return [ProductCollectionViewCell class];
}

- (NSString *)reusebleCollectionViewID{
    return CELL_COLLECTION_VIEW_ID;
}


#pragma mark - Utils

- (void)getDataForItemsFromCache:(BOOL)useCache{
    
    self.spinnerCount++;
    
    [[DataHelper instance] loadProductsUseCache:useCache
                              containtSubstinrg:nil
                                      OnSuccess:^(NSArray *products) {
                                          self.items = products;
                                          self.spinnerCount--;
                                      }
                                      onFailure:^(NSError *error){
                                          self.spinnerCount --;
                                      }];
}


#pragma mark - TABLE VIEW
#pragma mark - Delegate

- (UIView *)headerForTableView{
    return nil;
}

- (void)detailViewForIndex:(NSInteger)index{
    
    ProductModalViewController *mvc = [[ProductModalViewController alloc] init];
    
    if (self.items.count) {
        mvc.modalPresentationStyle = UIModalPresentationFormSheet;
        mvc.item = self.items[index];
        [self.tabBarController presentViewController:mvc
                                            animated:YES
                                          completion:^{
                                              mvc.item = self.items[index];
                                          }];
    }
}

- (CGFloat)heightForRow{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return HEIGHT_FOR_ROW_FOR_IPHONE;
    }else{
        return HEIGHT_FOR_ROW_FOR_IPAD;
    }
}

- (CGFloat)heightForHeaderInSection{
    return HEIGHT_FOR_HEADER_IN_SECTION;
}


#pragma mark - Data Source

- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        ProductViewCellForIPhone *cell = [[ProductViewCellForIPhone alloc] init];
        cell.item = self.items[indexPath.row];
        
        return cell;
        
    }else{
        ProductTableViewCell *cell = [[ProductTableViewCell alloc] init];
        cell.item = self.items[indexPath.row];
        
        return cell;
        
    }
    
}

- (NSString *)messageForEmptyItems{
    return LOC(PHVC_CELL_NO_PRODUCTS);
}


#pragma mark - Search Bar Delegate

- (void)sendSearchRequestWithString:(NSString *)searchString{
    
    [[DataHelper instance] loadProductsUseCache:YES
                              containtSubstinrg:searchString
                                      OnSuccess:^(NSArray *products) {
                                          self.isSearchProcess = NO;
                                          self.items = products;
                                          self.searchCountResultLabel.text = [NSString stringWithFormat:LOC(HaSVC_LEBEL_COUNT_RESULT), self.items.count];
                                      }
                                      onFailure:nil];
}


#pragma mark - COLLECTION VIEW
#pragma mark - Data Source

- (void)updateCell:(UICollectionViewCell *)cell forCollectionViewAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[ProductCollectionViewCell class]]) {
        ProductCollectionViewCell *cellForUpdate = (ProductCollectionViewCell *)cell;
        cellForUpdate.item = self.items[indexPath.row];
    }
}

@end
