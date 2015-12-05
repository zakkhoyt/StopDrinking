//
//  UIColor+ZH.m
//  ZH
//
//  Created by Zakk Hoyt on 4/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "UIColor+ZH.h"
#import "StopDrinking-Swift.h"

@implementation UIColor (ZH)

+(UIColor*)randomColor{
    return [UIColor randomColorWithAlpha:1.0];
}

+(UIColor*)randomColorWithAlpha:(float)alpha{
    CGFloat red = (arc4random() % 0xFF) / (float)0xFF;
    CGFloat blue = (arc4random() % 0xFF) / (float)0xFF;
    CGFloat green = (arc4random() % 0xFF) / (float)0xFF;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(UIColor*)randomSoftColor{
    return [UIColor randomSoftColorWithAlpha:1.0];
}

+(UIColor*)randomSoftColorWithAlpha:(float)alpha{
    CGFloat hue = ( arc4random() % 256 / 256.0 ); // 0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0, away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:alpha];
}


#pragma mark ZH


+(UIColor*)zhPurpleColor{
    return [UIColor colorWithRed:(119/(float)0xFF) green:(76/(float)0xFF) blue:(121/(float)0xFF) alpha:1.0];
}

+(UIColor*)zhYellowColor{
    return [UIColor colorWithRed:(246/(float)0xFF) green:(225/(float)0xFF) blue:(92/(float)0xFF) alpha:1.0];
}

+(UIColor*)zhRedColor{
    return [UIColor colorWithRed:(185/(float)0xFF) green:(73/(float)0xFF) blue:(57/(float)0xFF) alpha:1.0];
}
+(UIColor*)zhGreenColor{
    return [UIColor colorWithRed:(0x8E/(float)0xFF) green:(0xC4/(float)0xFF) blue:(0x64/(float)0xFF) alpha:1.0];
    
}
+(UIColor*)zhBlackColor{
    return [UIColor colorWithRed:(59/(float)0xFF) green:(71/(float)0xFF) blue:(80/(float)0xFF) alpha:1.0];
}

+(UIColor*)zhBlueColor{
    return [UIColor colorWithRed:(02/(float)0xFF) green:(0xBA/(float)0xFF) blue:(0xDB/(float)0xFF) alpha:1.0];
}

+(UIColor*)zhOrangeColor{
    return [UIColor colorWithRed:(0xFF/(float)0xFF) green:(0x9F/(float)0xFF) blue:(0x00/(float)0xFF) alpha:1.0];
}

+(UIColor*)zhDimBackgroundColor{
    return [[UIColor blackColor] colorWithAlphaComponent:0.5];
}








// See ZHDefines.h
#if defined(ZH_ALTERNATE_COLORS)



+(UIColor*)zhBackgroundColor{
    return [UIColor colorWithRed:(86.3/(float)0xFF) green:(86.3/(float)0xFF) blue:(86.3/(float)0xFF) alpha:1.0];
}
+(UIColor*)zhTranslucentBackgroundColor{
    return [[UIColor zhBackgroundColor] colorWithAlphaComponent:0.9];
}

+(UIColor*)zhTintColor{
    return [UIColor orangeColor];
}
+(UIColor*)zhAlternateTintColor{
    return [UIColor purpleColor];
}
+(UIColor*)zhLightTextColor{
    return [UIColor darkTextColor];
}
+(UIColor*)zhDarkTextColor{
    return [UIColor lightTextColor];
}

#else 
+(UIColor*)zhBackgroundColor{
//    return [UIColor colorWithRed:(243/(float)0xFF) green:(242/(float)0xFF) blue:(237/(float)0xFF) alpha:1.0];
//    return [UIColor colorWithRed:(0xEA/(float)0xFF) green:(0xD1/(float)0xFF) blue:(0x99/(float)0xFF) alpha:1.0];
    
//    E1D9D4 F1EDED
    return [UIColor colorWithRed:(0xF1/(float)0xFF) green:(0xED/(float)0xFF) blue:(0xED/(float)0xFF) alpha:1.0];
}
+(UIColor*)zhTranslucentBackgroundColor{
    return [[UIColor zhBackgroundColor] colorWithAlphaComponent:0.9];
}
+(UIColor*)zhTintColor{
    // Blue
//    return [UIColor colorWithRed:(02/(float)0xFF) green:(0xBA/(float)0xFF) blue:(0xDB/(float)0xFF) alpha:1.0];
    
//    #411C16
//        return [UIColor colorWithRed:(0x41/(float)0xFF) green:(0x1C/(float)0xFF) blue:(0x16/(float)0xFF) alpha:1.0];
//    7DB367
    return [UIColor colorWithRed:(0x7D/(float)0xFF) green:(0xB3/(float)0xFF) blue:(0x67/(float)0xFF) alpha:1.0];
}
+(UIColor*)zhAlternateTintColor{
    // Orange
//    return [UIColor zhOrangeColor];
//    return [UIColor zhGreenColor];
//    return [UIColor colorWithRed:(0XFF/(float)0xFF) green:(0x90/(float)0xFF) blue:(0x11/(float)0xFF) alpha:1.0];
    
//    2D4A3B
    return [UIColor colorWithRed:(0X2D/(float)0xFF) green:(0x4A/(float)0xFF) blue:(0x3B/(float)0xFF) alpha:1.0];
}
+(UIColor*)zhLightTextColor{
    return [UIColor lightTextColor];
}
+(UIColor*)zhDarkTextColor{
    return [UIColor darkTextColor];
}

#endif




@end
