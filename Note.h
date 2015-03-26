//
//  Note.h
//  BlocNotes
//
//  Created by Corey Norford on 3/19/15.
//  Copyright (c) 2015 Bloc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Note : NSManagedObject

@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSDate * timeCreated;
@property (nonatomic, retain) NSDate * timeUpdated;
@property (nonatomic, retain) NSString * title;

-(void)insert;
-(void)save;
-(void)delete;
- (id)initWithEntity:(NSEntityDescription*)entity insertIntoManagedObjectContext:(NSManagedObjectContext*)context;

+(Note *)findFirstMatchByText:(NSString *)note;
+(NSMutableArray *)findAll;
+(void)saveWithText:(NSString *)text;

@end
