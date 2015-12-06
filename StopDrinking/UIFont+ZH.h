//
//  UIFont+ZH.h
//  ZH
//
//  Created by Zakk Hoyt on 6/8/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

// Returns [UIFont preferredZHFontForTextStyle:...] + ZHFontPointSizeDelta points
static NSString *ZHFontTextStyleHeadline = @"ZHFontTextStyleHeadline";
static NSString *ZHFontTextStyleBody = @"ZHFontTextStyleBody";
static NSString *ZHFontTextStyleSubheadline = @"ZHFontTextStyleSubheadline";
static NSString *ZHFontTextStyleFootnote = @"ZHFontTextStyleFootnote";
static NSString *ZHFontTextStyleCaption1 = @"ZHFontTextStyleCaption1";
static NSString *ZHFontTextStyleCaption2 = @"ZHFontTextStyleCaption2";

// Returns [UIFont preferredZHFontForTextStyle:...] + ZHFontPointSizeDelta points and italic
static NSString *ZHFontTextStyleHeadlineItalic = @"ZHFontTextStyleHeadlineItalic";
static NSString *ZHFontTextStyleBodyItalic = @"ZHFontTextStyleBodyItalic";
static NSString *ZHFontTextStyleSubheadlineItalic = @"ZHFontTextStyleSubheadlineItalic";
static NSString *ZHFontTextStyleFootnoteItalic = @"ZHFontTextStyleFootnoteItalic";
static NSString *ZHFontTextStyleCaption1Italic = @"ZHFontTextStyleCaption1Italic";
static NSString *ZHFontTextStyleCaption2Italic = @"ZHFontTextStyleCaption2Italic";

// Returns [UIFont preferredZHFontForTextStyle:...] + ZHFontPointSizeDelta points and bold
static NSString *ZHFontTextStyleHeadlineBold = @"ZHFontTextStyleHeadlineBold";
static NSString *ZHFontTextStyleBodyBold = @"ZHFontTextStyleBodyBold";
static NSString *ZHFontTextStyleSubheadlineBold = @"ZHFontTextStyleSubheadlineBold";
static NSString *ZHFontTextStyleFootnoteBold = @"ZHFontTextStyleFootnoteBold";
static NSString *ZHFontTextStyleCaption1Bold = @"ZHFontTextStyleCaption1Bold";
static NSString *ZHFontTextStyleCaption2Bold = @"ZHFontTextStyleCaption2Bold";

@interface UIFont (ZH)
+(UIFont*)preferredZHFontForTextStyle:(NSString *)style;
@end
