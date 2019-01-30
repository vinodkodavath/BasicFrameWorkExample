//
//  Dimensions.h
//
//
//  Created by Tvisha Technologies on 12/29/16.
//  Copyright © 2016 Tvisha Technologies. All rights reserved.
//

#ifndef Dimensions_h
#define Dimensions_h

#define Max_Width [[UIScreen mainScreen] bounds].size.width
#define Max_Height [[UIScreen mainScreen] bounds].size.height
#define APDim_X [[UIScreen mainScreen] bounds].size.width/320
#define APDim_Y [[UIScreen mainScreen] bounds].size.height/568
#define ALDim_X [[UIScreen mainScreen] bounds].size.width/568
#define ALDim_Y [[UIScreen mainScreen] bounds].size.height/320
#define isiPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define isiPhone5  (([[UIScreen mainScreen] bounds].size.width == 320)||([[UIScreen mainScreen] bounds].size.width == 568))?1:0
#define isiPhone6  (([[UIScreen mainScreen] bounds].size.width == 375)||([[UIScreen mainScreen] bounds].size.width == 667))?1:0
#define isiPhone6s  (([[UIScreen mainScreen] bounds].size.width == 414) ||([[UIScreen mainScreen] bounds].size.width == 736))?1:0
#define isProtarit (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)?1:0
#define isLandScape (interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)?1:0
#define landsacpeMode UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)

//#define isRTL(effectiveUserInterfaceLayoutDirection == UISemanticContentAttributeForceRightToLeft)?1:0
//#define isRToL([NSLocale characterDirectionForLanguage:[[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode]]==NSLocaleLanguageDirectionRightToLeft)?1:0

/*system versions*/
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
/*structures*/
#import <UIKit/UIKit.h>

CG_INLINE CGRect CTRectMake(CGFloat x,
                            CGFloat y,
                            CGFloat width,
                            CGFloat height)
{
    CGRect rect;
    rect.origin.x    =  ([[UIScreen mainScreen] bounds].size.width/320)*x;
    rect.origin.y    = ([[UIScreen mainScreen] bounds].size.height/568)*y;
    rect.size.width  = ([[UIScreen mainScreen] bounds].size.width/320)*width;
    rect.size.height = ([[UIScreen mainScreen] bounds].size.height/568)*height;
    return rect;
}

typedef NS_ENUM(NSInteger, HOLIDAY_TYPE) {
    HOLIDAY_TYPE_NONE,
    HOLIDAY_TYPE_WEEKOFF,
    HOLIDAY_TYPE_CONFIRM,
    HOLIDAY_TYPE_OPTIONAL,
    HOLIDAY_TYPE_LEAVE,
    HOLIDAY_TYPE_COMPOFF,
    HOLIDAY_TYPE_PERMISSION,
};

#define poppinssemobold @"Poppins-SemiBold"
#define poppinsmedium @"Poppins-Medium"
#define poppinslight @"Poppins-Light"
#define palatinoItalic @"PalatinoLinotype-Italic"
#define poppinsbold @"Poppins-Bold"
#define poppinsItalic @"Poppins-Italic"

#endif /* Dimensions_h */
