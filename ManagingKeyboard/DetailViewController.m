//
//  DetailViewController.m
//  ManagingKeyboard
//
//  Created by Toshitaka Agata on 2012/12/14.
//  Copyright (c) 2012年 Toshitaka Agata. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
- (void)configureView;
@end

@implementation DetailViewController
{
    UIToolbar *toolBar;
}
#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
//        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
    // customize keyboard toolbar
    toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    toolBar.hidden = YES;
    toolBar.barStyle = UIBarStyleBlackOpaque;
    [toolBar sizeToFit];
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
    
    UIBarButtonItem *hide = [[UIBarButtonItem alloc] init];
    hide.target = self;
    hide.title = @"@Hide Keyword";
    hide.action = @selector(hideKeyboard:);
    hide.style = UIBarButtonItemStyleBordered;
    
    UIBarButtonItem *show = [[UIBarButtonItem alloc] init];
    show.target = self;
    show.title = @"@Show Keyword";
    show.action = @selector(showKeyboard:);
    show.style = UIBarButtonItemStyleBordered;
    
    NSArray *items = [NSArray arrayWithObjects:hide, spacer, show, nil];
    
    [self.view addSubview:toolBar];
    [toolBar setItems:items animated:YES];
    
    [_text becomeFirstResponder];
    
}

- (IBAction)hideKeyboard:(id)sender {
    NSLog(@"hide");
    [_text resignFirstResponder];
}

- (IBAction)showKeyboard:(id)sender {
    NSLog(@"show");
    [_text becomeFirstResponder];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSLog(@"keywordWasShown");
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    float y = self.view.bounds.size.height - kbSize.height - toolBar.bounds.size.height;
    toolBar.hidden = NO;
    toolBar.frame = CGRectMake(0, y, toolBar.bounds.size.width, toolBar.bounds.size.height);
    _text.frame = CGRectMake(0, 0, _text.bounds.size.width, y);
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    NSLog(@"keyboardWillBeHidden");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

- (void)viewDidUnload {
    [self setText:nil];
    [super viewDidUnload];
}
@end
