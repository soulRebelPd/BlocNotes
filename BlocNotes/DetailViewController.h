//
//  DetailViewController.h
//  TestMasterDetail
//
//  Created by Corey Norford on 3/18/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"

@interface DetailViewController : UIViewController <UIDocumentPickerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate>

@property (strong, nonatomic) Note *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *text;
@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (strong, nonatomic) UIDocumentPickerViewController *documentPicker;
@property (strong, nonatomic) NSData *importData;

- (IBAction)share:(id)sender;
- (IBAction)import:(id)sender;

@end

