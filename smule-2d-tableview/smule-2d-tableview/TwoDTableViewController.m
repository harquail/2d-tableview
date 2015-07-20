//
//  TwoDTableViewController.m
//  smule-2d-tableview
//
//  Created by nook on 7/14/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "TwoDTableViewController.h"
#import "CollectionViewTableViewCell.h"
#import <iTunesApi/ITunesApi.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "iTunesResultHandler.h"

#define kAlbumWidth 100

@interface TwoDTableViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property NSArray * countryCodes;
@property NSMutableDictionary * albumSearchResults;

@end

@implementation TwoDTableViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _countryCodes = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"iTunesCountries" ofType:@"plist"]];
        _albumSearchResults = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.dataSource = self;
    _tableView.rowHeight = kAlbumWidth + _tableView.sectionHeaderHeight/2;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections
    return _countryCodes.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return _countryCodes[section][@"Country"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //TODO: reuseMeAlso is wrong
    CollectionViewTableViewCell * cell = [[CollectionViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseMeAlso" itemSize:CGSizeMake(kAlbumWidth, kAlbumWidth)];
    
    NSString * country =  _countryCodes[indexPath.section][@"Code"];
    if (!_albumSearchResults[country]){
    [iTunesResultHandler getAlbumsForCountry:country withDelegate:self];
    }
    
    cell.collectionView.dataSource = self;
    cell.collectionView.tag = indexPath.section;
    
    return cell;
}

# pragma mark - UICollectionView data source

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray * resultsForCountry = _albumSearchResults[_countryCodes[collectionView.tag][@"Code"]];
    return resultsForCountry.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseMeAlso" forIndexPath:indexPath];
        UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell addSubview:imageView];
    cell.tag = indexPath.row;
    
    NSArray * resultsForCountry = _albumSearchResults[_countryCodes[collectionView.tag][@"Code"]];

    NSString * url;
    
    // set url to album artwork if it exists
    if(resultsForCountry.count > 0){
        ITunesAlbum * album = resultsForCountry[indexPath.row];
        url = album.artworkUrl100;
    }
    
    // get a placeholder image if the url is nil
    url = url ?: @"https://placeholdit.imgix.net/~text?txtsize=20&txt=90x90&w=90&h=90";
    
    // load images asynchronously
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                 placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                            [imageView setNeedsLayout];
                            [cell setNeedsLayout];
                        }];
    
    // add Tap handler
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnCell:)];
    [cell addGestureRecognizer:tap];
    
    return cell;
}

# pragma mark - private methods

- (void) handleTapOnCell:(UITapGestureRecognizer *)recognizer{
    
    NSInteger row = [[recognizer view] superview].tag;
    NSInteger  col = [recognizer view].tag;
    
    ITunesAlbum * album = _albumSearchResults[_countryCodes[row][@"Code"]][col];
    
    //create url for youtube search
    NSString * url = [[NSString stringWithFormat:@"http://m.youtube.com/results?q=%@ %@",album.collectionName,album.artistName] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    
}



- (int) rowForCountry: (NSString *) country{
    
    for (int i =0; i<_countryCodes.count; i++){
        if ([country isEqualToString:_countryCodes[i][@"Code"]]){
            return i;
        }
    }
    return -1;
}

- (void)resultsFetchedForCountry:(NSString *)country withResults:(NSArray *)results{
    
    int row = [self rowForCountry:country];
    NSIndexPath * indexPath =  [NSIndexPath indexPathForRow:0  inSection:row];
    _albumSearchResults[country] = results;
    if ([self.tableView.indexPathsForVisibleRows containsObject:indexPath]) {
        [_tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
    }
    
}


@end
