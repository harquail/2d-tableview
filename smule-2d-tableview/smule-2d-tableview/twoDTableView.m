//
//  twoDTableView.m
//  smule-2d-tableview
//
//  Created by nook on 7/20/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "twoDTableView.h"
#import "CollectionViewTableViewCell.h"

@implementation twoDTableView

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.twoDDataSource = self;
//        self.twoDDelegate = self;
//    }
//    return self;
//}


-(id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if(self)
    {
        self.dataSource = self;
    }
    
    return self;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [self.twoDDataSource cellInTwoDTableView:self collectionView:collectionView atRow:collectionView.tag atCol:indexPath.row];

    cell.tag = indexPath.row;
    
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


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections
    return [self.twoDDataSource rowsInTwoDTableView:self];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewTableViewCell * cell = [[CollectionViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseMe" itemSize:CGSizeMake(90, 90)];
    
    cell.collectionView.dataSource = self;
    cell.collectionView.tag = indexPath.section;
    
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


- (void) handleTapOnCell:(UITapGestureRecognizer *)recognizer{
    NSInteger row = [[recognizer view] superview].tag;
    NSInteger  col = [recognizer view].tag;
    if([self.twoDDelegate respondsToSelector:@selector(tappedCellAtRow:atCol:)]){
        [self.twoDDelegate tappedCellAtRow:row atCol:col];
    }
}


@end
