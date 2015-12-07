//
//  ZHStringFormatter.m
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/6/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import "ZHStringFormatter.h"

@implementation ZHStringFormatter

+(NSAttributedString*)bodyHTMLToAttributedString:(NSString*)bodyHTML {
    
    // Convert to actual HTML source
    NSString *decodedHTMLString = [ZHStringFormatter decodeHTMLString:bodyHTML];

    // Next make NSAttributedString from the HTML
    NSData *decodedHTMLData = [decodedHTMLString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *attributes = @{
                                 NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                 NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding),
                                 };
    NSError *error;
    NSMutableAttributedString *attrStrig = [[[NSAttributedString alloc]initWithData:decodedHTMLData options:attributes documentAttributes:nil error:&error] mutableCopy];
    
    // Finally, there are now links and such but the colors and fonts are wrong. Fix those.
    NSRange range = (NSRange){0,[attrStrig length]};
    [attrStrig enumerateAttribute:NSFontAttributeName inRange:range options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id value, NSRange range, BOOL *stop) {
        UIFont* currentFont = value;
        UIFont *replacementFont = nil;
        
        if ([currentFont.fontName rangeOfString:@"bold" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            replacementFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
            [attrStrig addAttribute:NSFontAttributeName value:replacementFont range:range];
            [attrStrig addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
        } else if ([currentFont.fontName rangeOfString:@"italic" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            UIFont *font = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
            replacementFont = [UIFont italicSystemFontOfSize:font.pointSize];
            [attrStrig addAttribute:NSFontAttributeName value:replacementFont range:range];
            [attrStrig addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
        } else if ([currentFont.fontName rangeOfString:@"courier" options:NSCaseInsensitiveSearch].location != NSNotFound) {
            UIFont *headlineFont = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
            UIFont *replacementFont = [UIFont fontWithName:currentFont.fontName size:headlineFont.pointSize];
            [attrStrig addAttribute:NSFontAttributeName value:replacementFont range:range];
            [attrStrig addAttribute:NSForegroundColorAttributeName value:[UIColor darkGrayColor] range:range];
            [attrStrig addAttribute:NSBackgroundColorAttributeName value:[UIColor whiteColor] range:range];
        } else {
            replacementFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
            [attrStrig addAttribute:NSFontAttributeName value:replacementFont range:range];
            [attrStrig addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:range];
        }
    }];
    return attrStrig;
}

#pragma mark Private methods

// Converts from a string like such:
// "&lt;div class=\"md\"&gt;&lt;p&gt;What a great idea! I look forward to the contributions. &lt;/p&gt;\n&lt;/div&gt;"
// to actual HTML string
// <div class="md"><p>What a great idea! I look forward to the contributions. </p> </div>
+(NSString*)decodeHTMLString:(NSString*)encodedHTMLString{
    NSData *bodyHTMLData = [encodedHTMLString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *attributes = @{
                                 NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                 NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding),
                                 };
    NSError *error;
    NSAttributedString *attrStr = [[NSAttributedString alloc]initWithData:bodyHTMLData options:attributes documentAttributes:nil error:&error];
    NSString *decodedHTML = attrStr.string;
    
    return decodedHTML;
    
}


@end
