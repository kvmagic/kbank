//
//  Util.m
//  IPSTARMobile
//
//  Created by Teera on 10/2/55 BE.
//  Copyright (c) 2555 Thaicom. All rights reserved.
//

#import "Util.h"
#import "Vars.h"

#import <sys/socket.h>
#import <netinet/in.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "math.h"
#import <EventKit/EventKit.h>

@implementation Util
+(NSArray *)GetAllDatabaseFileinBundle
{
    NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    
    //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *bundleRoot = [paths objectAtIndex:0];
    NSLog(@"%@", bundleRoot);
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.db'"];
    NSArray *onlyDBs = [dirContents filteredArrayUsingPredicate:fltr];
    for(int i = 0 ;i<[onlyDBs count];i++)
    {
        NSLog(@"%@", [onlyDBs objectAtIndex:i]);
    }
    return onlyDBs;
    //NSFileManager *fileManager = [[NSFileManager alloc]init];
    //NSHomeDirectory();
    //NSError *error;
    //return [fileManager contentsOfDirectoryAtPath:@"" error:&error];
}
+(NSArray *)GetAllDatabaseFile
{
    //NSString *bundleRoot = [[NSBundle mainBundle] bundlePath];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *bundleRoot = [paths objectAtIndex:0];
    NSLog(@"%@", bundleRoot);
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *dirContents = [fm contentsOfDirectoryAtPath:bundleRoot error:nil];
    NSPredicate *fltr = [NSPredicate predicateWithFormat:@"self ENDSWITH '.db'"];
    NSArray *onlyDBs = [dirContents filteredArrayUsingPredicate:fltr];
    for(int i = 0 ;i<[onlyDBs count];i++)
    {
        NSLog(@"%@", [onlyDBs objectAtIndex:i]);
    }
    return onlyDBs;
    //NSFileManager *fileManager = [[NSFileManager alloc]init];
    //NSHomeDirectory();
    //NSError *error;
    //return [fileManager contentsOfDirectoryAtPath:@"" error:&error];
}
+(BOOL)hasConnectivity {
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    SCNetworkReachabilityRef reachability = SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, (const struct sockaddr*)&zeroAddress);
    if(reachability != NULL) {
        //NetworkStatus retVal = NotReachable;
        SCNetworkReachabilityFlags flags;
        if (SCNetworkReachabilityGetFlags(reachability, &flags)) {
            if ((flags & kSCNetworkReachabilityFlagsReachable) == 0)
            {
                // if target host is not reachable
                return NO;
            }
            
            if ((flags & kSCNetworkReachabilityFlagsConnectionRequired) == 0)
            {
                // if target host is reachable and no connection is required
                //  then we'll assume (for now) that your on Wi-Fi
                return YES;
            }
            
            
            if ((((flags & kSCNetworkReachabilityFlagsConnectionOnDemand ) != 0) ||
                 (flags & kSCNetworkReachabilityFlagsConnectionOnTraffic) != 0))
            {
                // ... and the connection is on-demand (or on-traffic) if the
                //     calling application is using the CFSocketStream or higher APIs
                
                if ((flags & kSCNetworkReachabilityFlagsInterventionRequired) == 0)
                {
                    // ... and no [user] intervention is needed
                    return YES;
                }
            }
            
            if ((flags & kSCNetworkReachabilityFlagsIsWWAN) == kSCNetworkReachabilityFlagsIsWWAN)
            {
                // ... but WWAN connections are OK if the calling application
                //     is using the CFNetwork (CFSocketStream?) APIs.
                return YES;
            }
        }
    }
    
    return NO;
}

+ (NSString *) getWritableDBPath:(NSString *) databaseFile  {

    return [self getWritableDBPath:databaseFile IsDocument:YES];
}

+ (NSString *) getWritableDBPath:(NSString *) databaseFile IsDocument :(BOOL) isDocument {
    NSArray *paths;
    if (isDocument) {
        paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES);
    }else
    {
        paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory , NSUserDomainMask, YES);
    }
    NSString *documentsDir = [paths objectAtIndex:0];
  
    return [documentsDir stringByAppendingPathComponent:databaseFile];
}

+(void)createEditableCopyOfDatabaseIfNeeded:(NSString *) databaseFile
{
    [self createEditableCopyOfDatabaseIfNeeded:databaseFile IsDocument:YES];
}
+(void)createEditableCopyOfDatabaseIfNeeded:(NSString *) databaseFile IsDocument :(BOOL) isDocument 

{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths ;
    if(isDocument)
    {
        paths =
        NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    }else
    {
        paths =
        NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    }
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:databaseFile];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
        
        return;
    
    // The writable database does not exist, so copy the default to
    
    // the appropriate location.
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath]stringByAppendingPathComponent:databaseFile];
    
    //success = [fileManager removeItemAtPath:writableDBPath error:&error];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
    if(!success)
    {
        NSAssert1(0,@"Failed to create writable database file with Message : '%@'.",
                  
                  [error localizedDescription]);
        
    }
}

+ (UIImage *)burnTextIntoImage:(NSString *)text :(UIImage *)img {
    
    UIGraphicsBeginImageContext(img.size);
    
    CGRect aRectangle = CGRectMake(0,0, img.size.width, img.size.height);
    
    [img drawInRect:aRectangle];
    
    // [[UIColor redColor] set];// set text color
    
    
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:60 ];//[UIFont boldSystemFontOfSize: fontSizeBold];     // set text font
    NSMutableParagraphStyle *textStyle = [[NSMutableParagraphStyle defaultParagraphStyle] mutableCopy];
    textStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    textStyle.alignment = NSTextAlignmentCenter;
    
    [text drawInRect:aRectangle withAttributes:@{NSFontAttributeName:font, NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor redColor]}];
    //[text drawInRect:aRectangle withAttributes:@{NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName: [UIColor redColor]}];
    
    //[ text drawInRect : aRectangle withFont : font lineBreakMode : UILineBreakModeTailTruncation alignment : UITextAlignmentCenter ];
    
    UIImage *theImage=UIGraphicsGetImageFromCurrentImageContext();   // extract the image
    UIGraphicsEndImageContext();     // clean  up the context.
    return theImage;
}

+ (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    if (hours>24) {
        return [NSString stringWithFormat:@">24H"];
    }else
    {
        return [NSString stringWithFormat:@"(%02ld:%02ld:%02ld)", (long)hours, (long)minutes, (long)seconds];
    }
}
+(NSString *)CreateReminder:(EKEventStore *)eventStore Title:(NSString*)title Date:(NSDate*)date
{
    EKReminder *reminder = [EKReminder reminderWithEventStore:eventStore];
    reminder.title = title;
    reminder.calendar = [eventStore defaultCalendarForNewReminders];
    EKAlarm *alarm = [EKAlarm alarmWithAbsoluteDate:date];
    [reminder addAlarm:alarm];
    NSError *error = nil;
    [eventStore saveReminder:reminder commit:YES error:&error];
    if (error)
    {
        NSLog(@"error = %@", error);
        return @"-1";
    }
    return reminder.calendarItemIdentifier;
    //return eventStore.eventStoreIdentifier;
    
}
+(int)RemoveReminder:(EKEventStore *)eventStore EvenId:(NSString*)evenId
{
    
    EKReminder *reminder = (EKReminder *)[eventStore calendarItemWithIdentifier:evenId];
    
    //NSError *err;
    
    
    //EKReminder *reminder = (EKReminder *)[eventStore calendarItemWithIdentifier:eventId];
    
    //EKEvent* eventToRemove = [eventStore eventWithIdentifier:evenId];
    NSError* error = nil;
    if (reminder) {
        
        [eventStore removeReminder:reminder commit:YES error:&error];
        //[eventStore removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
    }
    if (error)
    {
        NSLog(@"error = %@", error);
        return -1;
    }
    else
    {
        return 1;
    }
}
+(UIImage*)getUIImageFromThisUIView:(UIView*)aUIView
{
    UIGraphicsBeginImageContext(aUIView.bounds.size);
    [aUIView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}
@end
