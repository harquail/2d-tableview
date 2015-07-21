//  twoDTableView.h
//  smule-2d-tableview//
//  Created by nook on 7/20/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 An object that adopts the twoDTableViewDataSource protocol is responsible for providing the data and views required by the two-dimensional tableview. A data source object represents your app’s data model and vends information to the table view as needed. It also handles the creation and configuration of cells and supplementary views used by the table view to display your data.
 */
@protocol twoDTableViewDataSource <NSObject>

/**
 Delegate method for number of rows in table view
 @param tableView the view requesting number of rows
*/
- (NSInteger) rowsInTwoDTableView: (UITableView *) tableView;

/**
 Delegate method for number of collumns in table view
 @param tableView the view requesting number of collumns
 @param inRow the row for which colums are requested
 */
- (NSInteger) colsInTwoDTableView: (UITableView *) tableView inRow: (NSInteger) row;

/**
 Delegate method for loading a collectionView cell
 @param tableView the view requesting a cell
 @param collectionView the collection view requesting a cell
 @param atCol the row of the requested cell
 @param atRow the row of the requested cell
 @return a UICollectionView cell
 */
- (UICollectionViewCell *) cellInTwoDTableView: (UITableView *) tableView collectionView: (UICollectionView *) collectionView atRow: (NSInteger) row atCol: (NSInteger) col;

/**
 Delegate method for setting the title for a section
 @param tableView the view requesting a title for a section
 @param atRow the row of the section title requested
 @return the section title as a string
 */
- (NSString *) sectionTitleInTwoDTableView: (UITableView *) tableView atRow: (NSInteger) row;

@end

/**
 Delegate for notifications about about table view state
 */
@protocol twoDTableViewDelegate <NSObject>

/**
 Triggered when a user taps a cell
 @param row an int representing row index
 @param col an int representing col index
 */
@optional - (void) tappedCellAtRow: (NSInteger) row atCol: (NSInteger) col;

/**
 Triggered when a tableview cell is loaded
 @param row an int representing row index
 */
@optional - (void) loadedRow: (NSInteger) row;

@end

/**
 A table view that contains a collection view within each table view cell
 */
@interface twoDTableView : UITableView <UITableViewDataSource, UICollectionViewDataSource>

/**
 Data source for 2D table view
 */
@property id<twoDTableViewDataSource> twoDDataSource;

/**
 Delegate notified about table updates
 */
@property id<twoDTableViewDelegate> twoDDelegate;

/**
 The default size for items
 */
@property CGSize itemSize;

@end

