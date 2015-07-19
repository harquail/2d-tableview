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

@interface TwoDTableViewController () 
@property (strong, nonatomic) IBOutlet TwoDTableView *tableView;

@property NSArray * countryCodes;

@property NSMutableDictionary * albumSearchResults;

@end

@implementation TwoDTableViewController


- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _countryCodes = [NSArray arrayWithContentsOfFile: [[NSBundle mainBundle] pathForResource:@"iTunesCountries"
                                                                                          ofType:@"plist"]];
        _albumSearchResults = [[NSMutableDictionary alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.rowHeight = 100.0;

    
    for (NSDictionary * countryDict in _countryCodes){
        NSString * countryCode = countryDict[@"Code"];
        
        sleep(0.5);
        iTunesResultHandler * resultHandler = [[iTunesResultHandler alloc] initWithCountry:countryCode];
        resultHandler.delegate = self;
        [resultHandler searchForAlbumArtwork];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int) rowForCountry: (NSString *) country{
    for (int i =0; i<_countryCodes.count; i++){
//        NSLog(@"%@", _countryCodes[i][@"Country"]);
        if ([country isEqualToString:_countryCodes[i][@"Code"]]){
            return i;
        }
    }
    return -1;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfColumnsInRow:(NSInteger)row{
//    return 5;
//}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"reached collection view delegate");

    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseMeAlso" forIndexPath:indexPath];
    
    // row, collumn
    NSLog(@"%ld %ld",(long)collectionView.tag,(long)indexPath.row);
//    cell.backgroundColor  = [self randomColor];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell addSubview:imageView];
    
    
    NSArray * resultsForCountry = _albumSearchResults[_countryCodes[collectionView.tag][@"Code"]];
    
    NSString * url;
    if(resultsForCountry.count > indexPath.row){
        ITunesAlbum * album = resultsForCountry[indexPath.row];
        url = album.artworkUrl100;
    }
    
    url = url ?: @"https://avatars1.githubusercontent.com/u/6343948?v=3&s=460";
    
    [imageView sd_setImageWithURL:[NSURL URLWithString:url]
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                 [imageView setNeedsLayout];
                                 [cell setNeedsLayout];
                                }];

 
    
    return cell;
}

- (UIColor *) randomColor{

        CGFloat hue = ( arc4random() % 256 / 256.0 );  //  0.0 to 1.0
        CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from white
        CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;  //  0.5 to 1.0, away from black
        return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _countryCodes.count;
}

//- (UICollectionViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath columnAtIndexPath:(NSIndexPath *)indexPath2{
//    
//    
//    
//    UICollectionViewCell * cell = [[UICollectionViewCell alloc] init];
//    cell.backgroundColor = [self randomColor];
//    
//    return cell;
//}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    //TODO: this should work!!
//    CollectionViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseMe"];
//
//    if(cell == nil){
        CollectionViewTableViewCell * cell = [[CollectionViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseMeAlso"];
//    }
    
    
//    cell.rower = (int)indexPath.row;
//    cell.dataSource = self;
    NSLog(@"%@",cell.collectionView);
    cell.collectionView.dataSource = self;
    // use tag to keep track of row
    cell.collectionView.tag = indexPath.row;
    cell.collectionView.backgroundColor = [self randomColor];
//    self.collectionView.bounds = self.bounds;
    
    return cell;
}

- (void)resultsFetchedForCountry:(NSString *)country withResults:(NSArray *)results{
    
    
    int row = [self rowForCountry:country];
    NSIndexPath * indexPath =  [NSIndexPath indexPathForRow: row inSection:0];

       for (ITunesAlbum * album in results){
        _albumSearchResults[country] = results;
        
        NSLog(@"country: %@ albumURL: %@",country, album.artworkUrl100);
    }
    
    if ([self.tableView.indexPathsForVisibleRows containsObject:indexPath]) {
    [_tableView reloadRowsAtIndexPaths: [NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
