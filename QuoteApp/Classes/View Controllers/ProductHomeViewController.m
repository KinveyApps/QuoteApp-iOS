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

@interface ProductHomeViewController ()

@end

@implementation ProductHomeViewController

- (void)getDataForItemsFromCache:(BOOL)useCache{
    
    self.spinnerCount++;
    [[DataHelper instance] loadProductsUseCache:useCache
                             containtSubstinrg:@""
                                     OnSuccess:^(NSArray *products) {
                                                self.items = products;
                                                self.spinnerCount--;
                                            }
                                     onFailure:^(NSError *error){
                                                self.spinnerCount --;
                                            }];
}

- (UIView *)headerForTableView{
    return nil;
}

- (BOOL)isVisibleTableGridSegmentedControl{
    return NO;
}

- (Class)classForCollectionViewCell{
    return [ProductCollectionViewCell class];
}

#define CELL_COLLECTION_VIEW_ID @"Product CV Cell"

- (NSString *)reusebleCollectionViewID{
    return CELL_COLLECTION_VIEW_ID;
}

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

- (void)sendSearchRequestWithString:(NSString *)searchString{
    
    [[DataHelper instance] loadProductsUseCache:YES
                             containtSubstinrg:searchString
                                     OnSuccess:^(NSArray *products) {
                                                self.isSearchProcess = NO;
                                                self.items = products;
                                                self.spinnerCount --;
                                                self.searchCountResultLabel.text = [NSString stringWithFormat:LOC(HaSVC_LEBEL_COUNT_RESULT), self.items.count];
                                            }
                                     onFailure:^(NSError *error){
                                                self.spinnerCount --;
                                            }];
}

- (CGFloat)heightForRow{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 100;
    }else{
        return 180;
    }
}

- (CGFloat)heightForHeaderInSection{
    return 0;
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

- (NSString *)messageForEmptyItems{
    return LOC(PHVC_CELL_NO_PRODUCTS);
}

- (NSString *)titleForRefreshControl{
    return LOC(PHVC_REFRESH_CONTROL_TITLE);
}

- (void)updateCell:(UICollectionViewCell *)cell forCollectionViewAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell isKindOfClass:[ProductCollectionViewCell class]]) {
        ProductCollectionViewCell *cellForUpdate = (ProductCollectionViewCell *)cell;
        cellForUpdate.item = self.items[indexPath.row];
    }
}

@end
