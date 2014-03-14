//
//  OrderHomeViewController.m
//  QuoteApp
//
//  Created by Pavel Vilbik on 27.2.14.
//  Copyright (c) 2014 Kinvey, Inc. All rights reserved.
//

#import "OrderHomeViewController.h"
#import "MainTableHeaderView.h"
#import "MainTableViewCell.h"
#import "MainTableHeaderViewForIPhone.h"
#import "MainTableViewCellForIPhone.h"
#import "QuoteOrderModalViewController.h"

@interface OrderHomeViewController ()

@end

@implementation OrderHomeViewController


- (void)getDataForItemsFromCache:(BOOL)useCache{
    
    self.spinnerCount++;
    
    [[DataHelper instance] loadOrdersUseCache:useCache
                           containtSubstinrg:@""
                                   OnSuccess:^(NSArray *orders) {
                                                self.items = orders;
                                                self.spinnerCount--;
                                            }
                                   onFailure:^(NSError *error){
                                                self.spinnerCount --;
                                            }];
}

- (UIView *)headerForTableView{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        MainTableHeaderViewForIPhone *header = [[MainTableHeaderViewForIPhone alloc] initWithFrame:CGRectZero];
        header.type = HeaderViewMainTableTypeQuotes;
        return header;
    }else{
        MainTableHeaderView *header = [[MainTableHeaderView alloc] initWithFrame:CGRectZero];
        header.type = HeaderViewMainTableTypeOrder;
        return header;
    }
}

- (UITableViewCell *)cellForTableViewAtIndexPath:(NSIndexPath *)indexPath{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        MainTableViewCellForIPhone * cell = [[MainTableViewCellForIPhone alloc] init];
        cell.item = self.items[indexPath.row];
        return cell;
    }else{
        MainTableViewCell *cell = [[MainTableViewCell alloc] init];
        cell.item = self.items[indexPath.row];
        return cell;
    }
}

- (void)sendSearchRequestWithString:(NSString *)searchString{
    
    [[DataHelper instance] loadOrdersUseCache:YES
                           containtSubstinrg:searchString
                                   OnSuccess:^(NSArray *orders) {
                                                self.isSearchProcess = NO;
                                                self.items = orders;
                                                self.spinnerCount --;
                                                self.searchCountResultLabel.text = [NSString stringWithFormat:LOC(HaSVC_LEBEL_COUNT_RESULT), self.items.count];
                                            }
                                   onFailure:^(NSError *error){
                                                self.spinnerCount --;
                                            }];
}

- (CGFloat)heightForRow{
    return 44;
}

- (CGFloat)heightForHeaderInSection{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        return 60;
    }else{
        return 95;
    }
}

- (void)detailViewForIndex:(NSInteger)index{
    QuoteOrderModalViewController *mvc = [[QuoteOrderModalViewController alloc] init];
    if (self.items.count) {
        mvc.modalPresentationStyle = UIModalPresentationFormSheet;
        mvc.item = self.items[index];
        [self.tabBarController presentViewController:mvc
                                            animated:YES
                                          completion:^{
                                          }];
    }
}

- (NSString *)messageForEmptyItems{
    return LOC(OHVC_CELL_NO_ORDER);
}

- (NSString *)titleForRefreshControl{
    return LOC(OHVC_REFRESH_CONTROL_TITLE);
}

- (NSString *)titleForView{
    return LOC(OHVC_TITLE);
}

@end
