//
//  CollectionViewTableViewCell.m
//  smule-2d-tableview
//
//  Created by nook on 7/14/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "CollectionViewTableViewCell.h"

@implementation CollectionViewTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    NSLog(@"reached init with frame");
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.itemSize = CGSizeMake(self.frame.size.height * 1.9, self.frame.size.height * 1.9);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.collectionView setUserInteractionEnabled:YES];
        [self.collectionView setShowsHorizontalScrollIndicator:NO];
        [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];

        [self.contentView addSubview:self.collectionView];
        
    }
    return self;


}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = self.contentView.bounds;
}


- (instancetype)initWithFrame:(CGRect)frame{
    NSLog(@"reached init with frame");
    self = [super initWithFrame:frame];
    if (self) {
        self.collectionView = [[UICollectionView alloc] init];
        [self.contentView addSubview:self.collectionView];
        [self layoutSubviews];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
