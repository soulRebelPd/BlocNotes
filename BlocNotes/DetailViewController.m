//
//  DetailViewController.m
//  TestMasterDetail
//
//  Created by Corey Norford on 3/18/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        
        self.text.text = self.detailItem.text;
        self.titleField.text = self.detailItem.title;
        
        //        if([self.detailItem.text isEqualToString:@""]){
        //            self.text.text = @"Enter Note...";
        //        }
        //        else{
        //            self.text.text = self.detailItem.text;
        //        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    if (self.isMovingFromParentViewController) {
        self.detailItem.text = self.text.text;
        self.detailItem.title = self.titleField.text;
        [self.detailItem save];
    }
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        [self configureView];
    }
}

- (IBAction)share:(id)sender {
    NSMutableArray *itemsToShare = [NSMutableArray array];
    
    if (self.detailItem.text.length > 0) {
        [itemsToShare addObject:self.text.text];
    }
    
    if (itemsToShare.count > 0) {
        UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
        [self presentViewController:activityVC animated:YES completion:nil];
    }
}

-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

@end
