//
//  Vars.h
//  xml
//
//  Created by kittidechv on 10/30/2557 BE.
//  Copyright (c) 2557 gambook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Vars : NSObject
{
    
}

+(NSString *)GetDBName;

+(NSString *)GetImageHeaderBar;
+(NSString *)GetImageHeaderBarIpad;
+(int)GetSize;
+(int)GetSizeHeaderBold;
+(int)GetSizeBold;

+(int)GetDefaultColor;
+(int)GetDefaultSeparatorColor;

+(float)GetRecommendAlpha;

+(int)ToGMT;
+(NSTimeInterval)GetSecondsInTwoHours;

+(NSString *)GetPublishKey;
+(NSString *)GetSubscribeKey;
+(NSString *)GetCipherKey;

+(int)SecTimeoutForRemoteControl;
+(float)SecTimeoutForWebservice;

+(UIColor *)GetBlueDefaultColor;
+(UIColor *)GetRedDefaultColor;

@end
