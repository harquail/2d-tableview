//
//  twoDTableView.m
//  smule-2d-tableview
//
//  Created by nook on 7/20/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "twoDTableView.h"
#import "CollectionViewTableViewCell.h"
#define kDefaultItemSize 90

@implementation twoDTableView

-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self)
    {
        self.dataSource = self;
        // default item size, can be overridden either at the tableview level
        // or by setting a collectionViewLayoutDelegate for dynamically sizing individual cells
        self.itemSize = CGSizeMake(kDefaultItemSize, kDefaultItemSize);
    }
    
    return self;
}

#pragma mark - UICollectionView data source methods

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    // ask data source for a cell
    UICollectionViewCell * cell = [self.twoDDataSource cellInTwoDTableView:self collectionView:collectionView atRow:collectionView.tag atCol:indexPath.row];

    // keep track of collumn using cell tag
    cell.tag = indexPath.row;

    // add tap handler
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnCell:)];
    [cell addGestureRecognizer:tap];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.twoDDataSource colsInTwoDTableView:self inRow:collectionView.tag];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

#pragma mark - UITableView data source methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewTableViewCell * cell = [[CollectionViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseMe" itemSize:self.itemSize];
    cell.collectionView.dataSource = self;
    // keep track of row using collectionView tag
    cell.collectionView.tag = indexPath.section;
    
    // send message to delegate
    if([self.twoDDelegate respondsToSelector:@selector(loadedRow:)]){
        [self.twoDDelegate loadedRow:indexPath.section];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [self.twoDDataSource sectionTitleInTwoDTableView:tableView atRow:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // ask data source for number of sections
    return [self.twoDDataSource rowsInTwoDTableView:self];
}


#pragma mark - private method

- (void) handleTapOnCell:(UITapGestureRecognizer *)recognizer{
    NSInteger row = [[recognizer view] superview].tag;
    NSInteger  col = [recognizer view].tag;
    if([self.twoDDelegate respondsToSelector:@selector(tappedCellAtRow:atCol:)]){
        [self.twoDDelegate tappedCellAtRow:row atCol:col];
    }
}


@end
