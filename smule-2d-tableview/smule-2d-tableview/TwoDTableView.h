//
//  TwoDTableView.h
//  
//
//  Created by nook on 7/14/15.
//
//

#import <UIKit/UIKit.h>



@protocol TwoDTableViewDataSource<UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
- (NSInteger)tableView:(UITableView *)tableView numberOfColumnsInRow:(NSInteger)row;
- (UICollectionViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath columnAtIndexPath:(NSIndexPath * )indexPath;

@end

@protocol TwoDTableViewDelegate<UITableViewDelegate>


@end

@interface TwoDTableView : UITableView <UICollectionViewDataSource>


@end
