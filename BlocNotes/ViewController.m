//
//  ViewController.m
//  BlocNotes
//
//  Created by Corey Norford on 3/15/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import "ViewController.h"
#import "Note.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)saveData:(id)sender {
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    NSManagedObject *newContact;
    newContact = [NSEntityDescription
                  insertNewObjectForEntityForName:@"Contacts"
                  inManagedObjectContext:context];
    [newContact setValue: _name.text forKey:@"name"];
    [newContact setValue: _address.text forKey:@"address"];
    [newContact setValue: _phone.text forKey:@"phone"];
    _name.text = @"";
    _address.text = @"";
    _phone.text = @"";
    NSError *error;
    [context save:&error];
}

- (IBAction)find:(id)sender {
    AppDelegate *appDelegate =
    [[UIApplication sharedApplication] delegate];
    
    NSManagedObjectContext *context =
    [appDelegate managedObjectContext];
    
    NSEntityDescription *entityDesc =
    [NSEntityDescription entityForName:@"Contacts"
                inManagedObjectContext:context];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDesc];
    
    NSPredicate *pred =
    [NSPredicate predicateWithFormat:@"(name = %@)",
     _name.text];
    [request setPredicate:pred];
    NSManagedObject *matches = nil;
    
    NSError *error;
    NSArray *objects = [context executeFetchRequest:request
                                              error:&error];
    
    if ([objects count] == 0) {
        _phone.text = @"";
    } else {
        matches = objects[0];
        _address.text = [matches valueForKey:@"address"];
        _phone.text = [matches valueForKey:@"phone"];
    }
}

- (IBAction)saveNote:(id)sender {
    Note *note = [[Note alloc] init];
    [note setText: @"hello2"];
    [note insert];
}

- (IBAction)findNote:(id)sender {
    Note *note = [Note findFirstMatchByText:@"hello2"];
}

- (IBAction)findAll:(id)sender {
    NSArray *allNotes = [Note findAll];
}

- (IBAction)delete:(id)sender {
    Note *note = [[Note alloc] init];
    note.text = @"hello2";
    [note delete];
}
@end
