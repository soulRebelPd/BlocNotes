//
//  ViewController.h
//  BlocNotes
//
//  Created by Corey Norford on 3/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *phone;

- (IBAction)saveData:(id)sender;
- (IBAction)find:(id)sender;
- (IBAction)saveNote:(id)sender;
- (IBAction)findNote:(id)sender;
- (IBAction)findAll:(id)sender;
- (IBAction)delete:(id)sender;

@end

