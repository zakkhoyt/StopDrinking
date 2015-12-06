//
//  UIColor+ZH.h
//  ZH
//
//  Created by Zakk Hoyt on 4/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZH)
+(UIColor*)randomColor;
+(UIColor*)randomColorWithAlpha:(float)alpha;
+(UIColor*)randomSoftColor;
+(UIColor*)randomSoftColorWithAlpha:(float)alpha;


+(UIColor*)zhPurpleColor;
+(UIColor*)zhRedColor;
+(UIColor*)zhGreenColor;
+(UIColor*)zhBlackColor;
+(UIColor*)zhBlueColor;
+(UIColor*)zhOrangeColor;
+(UIColor*)zhDimBackgroundColor;


+(UIColor*)zhBackgroundColor;
+(UIColor*)zhTranslucentBackgroundColor;
+(UIColor*)zhTintColor;
+(UIColor*)zhAlternateTintColor;
+(UIColor*)zhLightTextColor;
+(UIColor*)zhDarkTextColor;



@end
