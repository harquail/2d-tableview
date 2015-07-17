//
//  TwoDTableViewController.m
//  smule-2d-tableview
//
//  Created by nook on 7/14/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import "TwoDTableViewController.h"
#import "CollectionViewTableViewCell.h"

@interface TwoDTableViewController ()
@property (strong, nonatomic) IBOutlet TwoDTableView *tableView;

@end

@implementation TwoDTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfColumnsInRow:(NSInteger)row{
    return 5;
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 50;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    NSLog(@"reached collection view delegate");

    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseMeAlso" forIndexPath:indexPath];
    
    cell.backgroundColor  = [self randomColor];
//                                   
//                                   if (cell == nil){
//                                       cell = [[UICollectionViewCell alloc] init];
//                                   }

                                   //

//    
//    return cell;
    
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
    return 100;
}

- (UICollectionViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath columnAtIndexPath:(NSIndexPath *)indexPath2{
    
    
    
    UICollectionViewCell * cell = [[UICollectionViewCell alloc] init];
    cell.backgroundColor = [self randomColor];
    
    return cell;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    //TODO: this should work!!
//    CollectionViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseMe"];
//
//    if(cell == nil){
        CollectionViewTableViewCell * cell = [[CollectionViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"reuseMe"];
//    }
    
    
//    cell.rower = (int)indexPath.row;
//    cell.dataSource = self;
    NSLog(@"%@",cell.collectionView);
    cell.collectionView.dataSource = self;
    cell.collectionView.backgroundColor = [self randomColor];
//    self.collectionView.bounds = self.bounds;
    
    return cell;
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
