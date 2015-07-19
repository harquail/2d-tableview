//
//  TwoDTableViewController.h
//  smule-2d-tableview
//
//  Created by nook on 7/14/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwoDTableView.h"
#import "iTunesResultHandler.h"

@interface TwoDTableViewController : UIViewController <TwoDTableViewDataSource, UICollectionViewDataSource, iTunesResultHandlerDelegate>

@end
