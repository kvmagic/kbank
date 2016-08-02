//
//  Vars.m
//  xml
//
//  Created by kittidechv on 10/30/2557 BE.
//  Copyright (c) 2557 gambook. All rights reserved.
//

#import "Vars.h"

#define fontSizeHeaderBold 24
#define fontSizeBold 22
#define fontSize 21
#define USE_IOS_SETTING

#define DATABASE_NAME @"kbank.sqlite"

NSString* ipForIphone;

@implementation Vars

+(NSString *)GetDBName
{
    return DATABASE_NAME;
}

+(NSString *)GetImageHeaderBar
{
    return @"Head-Bar.png";
}
+(NSString *)GetImageHeaderBarIpad
{
    return @"Head-Bar-Ipad.png";
}

+(int)GetSize
{
    return fontSize;
}
+(int)GetSizeBold
{
    return fontSizeBold;
}

+(int)GetSizeHeaderBold;
{
    return fontSizeHeaderBold;
}

+(int)GetDefaultColor
{
    return 49;
}
+(int)GetDefaultSeparatorColor
{
    return 94;
}


+(int)ToGMT
{
    return 7*60*60;
}

+(NSTimeInterval)GetSecondsInTwoHours
{
    return 2*60*60;
}


+(NSString *)GetPublishKey
{
    return @"pub-c-635f6d16-9f0c-4f70-be06-1da70a687cc2";
}
+(NSString *)GetSubscribeKey
{
    return @"sub-c-f7453fbe-ad8c-11e3-9bee-02ee2ddab7fe";
}
+(NSString *)GetCipherKey
{
    return @"sec-c-YWJiMTQ3MGYtY2ZiZi00MGMyLWJlNGUtYWE2ZGE5Y2QwMGIw";
}

+(int)SecTimeoutForRemoteControl
{
    return 5;
}

+(float)GetRecommendAlpha
{
    return 1.0;
}

+(float)SecTimeoutForWebservice
{
    
    return 10.0;
}

+(UIColor *)GetBlueDefaultColor
{
    return [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];}
+(UIColor *)GetRedDefaultColor
{
    return [UIColor redColor];
}
@end
