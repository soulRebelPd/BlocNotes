//
//  DetailViewController.m
//  TestMasterDetail
//
//  Created by Corey Norford on 3/18/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "DetailViewController.h"
#import <UIKit/UIKit.h>

@interface DetailViewController ()
@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.titleField.delegate = self;
    
    UITapGestureRecognizer *tapGestureRecognizerOnText = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnText:)];
    [self.text addGestureRecognizer:tapGestureRecognizerOnText];
    tapGestureRecognizerOnText.delegate = self;
    
    UITapGestureRecognizer *tapGestureRecognizerOnTitle = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapOnTitle:)];
    [self.titleField addGestureRecognizer:tapGestureRecognizerOnTitle];
    tapGestureRecognizerOnTitle.delegate = self;
    
    self.text.editable = NO;
    
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

- (IBAction)import:(id)sender {
    self.documentPicker = [[UIDocumentPickerViewController alloc]
                           initWithDocumentTypes:@[@"public.content"]
                           inMode:UIDocumentPickerModeImport];
    
    self.documentPicker.delegate = self;
    self.documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:self.documentPicker animated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url {
    // NOTE: consider refactoring into an object
    // import data
    // extract string from data
    // notify user of success
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    
    NSURLSessionDownloadTask *getImageTask = [session
                                              downloadTaskWithURL:url
                                              completionHandler:^(NSURL *location,
                                                                  NSURLResponse *response,
                                                                  NSError *error) {
                                                  
                                                  NSData *importData = [NSData dataWithContentsOfURL:location];
                                                  
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      
                                                      NSAttributedString *attributedStr = [[NSAttributedString alloc]
                                                                                           initWithData:importData
                                                                                           options:@{NSDocumentTypeDocumentAttribute:NSRTFTextDocumentType}
                                                                                           documentAttributes:nil
                                                                                           error:nil];
                                                      
                                                      self.text.text = [attributedStr string];
                                                      
                                                      if (controller.documentPickerMode == UIDocumentPickerModeImport) {
                                                          NSString *alertMessage = [NSString stringWithFormat:@"Successfully imported %@", [url lastPathComponent]];
                                                          dispatch_async(dispatch_get_main_queue(), ^{
                                                              UIAlertController *alertController = [UIAlertController
                                                                                                    alertControllerWithTitle:@"Import"
                                                                                                    message:alertMessage
                                                                                                    preferredStyle:UIAlertControllerStyleAlert];
                                                              [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                                                              [self presentViewController:alertController animated:YES completion:nil];
                                                          });
                                                      }
                                                      
                                                  });
                                              }];
    
    [getImageTask resume];
}

-(BOOL)automaticallyAdjustsScrollViewInsets{
    return NO;
}

- (void) handleTapOnText: (UITapGestureRecognizer *)recognizer
{
    self.text.editable = YES;
}

-(void) textFieldDidBeginEditing:(UITextField *)textField{
    self.text.editable = NO;
}

@end
