//
//  DetailViewController.h
//  ManagingKeyboard
//
//  Created by Toshitaka Agata on 2012/12/14.
//  Copyright (c) 2012年 Toshitaka Agata. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UITextView *text;

//@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
