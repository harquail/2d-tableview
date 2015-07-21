//
//  topAlbumsViewController.h
//  smule-2d-tableview
//
//  Created by nook on 7/20/15.
//  Copyright (c) 2015 nook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "twoDTableView.h"

/**
 View controller that displays the top albums for each country
 */
@interface topAlbumsViewController : UIViewController  <twoDTableViewDataSource, twoDTableViewDelegate>

@end
