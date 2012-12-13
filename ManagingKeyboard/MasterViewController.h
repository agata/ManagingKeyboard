//
//  MasterViewController.h
//  ManagingKeyboard
//
//  Created by Toshitaka Agata on 2012/12/14.
//  Copyright (c) 2012年 Toshitaka Agata. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

@end
