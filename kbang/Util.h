//
//  Util.h
//  IPSTARMobile
//
//  Created by Teera on 10/2/55 BE.
//  Copyright (c) 2555 Thaicom. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vars.h"
#import <EventKit/EventKit.h>

@interface Util : NSObject
+(NSArray *)GetAllDatabaseFile;
+(NSArray *)GetAllDatabaseFileinBundle;
+(BOOL)hasConnectivity;
+(NSString *)getWritableDBPath:(NSString *) databaseFile;
+(NSString *)getWritableDBPath:(NSString *) databaseFile IsDocument :(BOOL) isDocument ;
+(void)createEditableCopyOfDatabaseIfNeeded:(NSString *) databaseFile;
+(void)createEditableCopyOfDatabaseIfNeeded:(NSString *) databaseFile IsDocument :(BOOL) isDocument ;
+(UIImage *)burnTextIntoImage:(NSString *)text :(UIImage *)img;

+(NSString *)stringFromTimeInterval:(NSTimeInterval)interval;
+(NSString *)CreateReminder:(EKEventStore *)eventStore Title:(NSString*)title Date:(NSDate*)date;

+(UIImage*)getUIImageFromThisUIView:(UIView*)aUIView;
@end
