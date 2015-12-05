//
//  UIFont+ZH.m
//  ZH
//
//  Created by Zakk Hoyt on 6/8/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "UIFont+ZH.h"

const CGFloat ZHFontPointSizeDelta = 0;

@implementation UIFont (ZH)

+(UIFont*)preferredZHFontForTextStyle:(NSString *)style{
    
    if([style isEqualToString:ZHFontTextStyleHeadline]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        return [UIFont systemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleBody]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        return [UIFont systemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleSubheadline]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        return [UIFont systemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleFootnote]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        return [UIFont systemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleCaption1]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        return [UIFont systemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleCaption2]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
        return [UIFont systemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleHeadlineItalic]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        return [UIFont italicSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleBodyItalic]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        return [UIFont italicSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleSubheadlineItalic]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        return [UIFont italicSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleFootnoteItalic]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        return [UIFont italicSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleCaption1Italic]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        return [UIFont italicSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleCaption2Italic]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
        return [UIFont italicSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleHeadlineBold]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
        return [UIFont boldSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleBodyBold]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
        return [UIFont boldSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleSubheadlineBold]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline];
        return [UIFont boldSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleFootnoteBold]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
        return [UIFont boldSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleCaption1Bold]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];
        return [UIFont boldSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    } else if([style isEqualToString:ZHFontTextStyleCaption2Bold]){
        UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
        return [UIFont boldSystemFontOfSize:font.pointSize + ZHFontPointSizeDelta];
    }
    
    return nil;
}

@end
