//
//  NSDate+ZH.m
//  ZH
//
//  Created by Zakk Hoyt on 4/20/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "NSDate+ZH.h"
#import "NSDate+Utilities.h"
#import "StopDrinking-Swift.h"

@implementation NSDate (ZH)


+(NSDate*)dateFromStringDownToTheSecond:(NSString*)string{
    NSString *dateFormatString = @"EEEE MMMM dd, YYYY @HH:mm";
    
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSDate *date = [dateLocal dateFromString:string];
    return date;
}
+(NSString*)stringForRangeStartDat1:(NSDate*)startDate endDate:(NSDate*)endDate{
    if(startDate == nil && endDate == nil){
        return @"";
    }
    
    // If first and last dates have different day components, return the range. Else return only the startDate string.
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger components = NSCalendarUnitDay;
    NSDateComponents *firstComponents = [calendar components:components fromDate:startDate];
    NSDateComponents *secondComponents = [calendar components:components fromDate:endDate];
    if(firstComponents.day != secondComponents.day){
        NSString *firstDateString = [NSString stringWithFormat:@"%@", [startDate stringFromDateDayOnlyShort]];
        NSString *lastDateString = [NSString stringWithFormat:@"%@", [endDate stringFromDateDayOnlyShort]];
        NSString *dateString = [NSString stringWithFormat:@"%@ - %@", firstDateString, lastDateString];
        return dateString;
    } else {
        if(startDate){
            NSString *dateString = [NSString stringWithFormat:@"%@", [startDate stringFromDateDayOnlyShort]];
            return dateString;
        } else if(endDate) {
            NSString *dateString = [NSString stringWithFormat:@"%@", [endDate stringFromDateDayOnlyShort]];
            return dateString;
        } else {
            return @"";
        }
    }
}


-(NSString*)stringFromDateDownToTheSecond{
    NSString *dateFormatString = @"EEEE MMMM dd, YYYY @HH:mm";
    
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    return dateString;
}


-(NSString*)stringFromDateAndTime{
    
    NSString *dateFormatString = @"EEEE MMMM dd, YYYY @HH:mm";
    NSString *hourFormatString = @"HH:mm";
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    
    if([self isToday]){
        [dateLocal setDateFormat:hourFormatString];
        return [NSString stringWithFormat:@"Today %@", [dateLocal stringFromDate:self]];
    }
    else if([self isTomorrow]){
        [dateLocal setDateFormat:hourFormatString];
        return [NSString stringWithFormat:@"Tomorrow %@", [dateLocal stringFromDate:self]];
    }
    else if([self isYesterday]) {
        [dateLocal setDateFormat:hourFormatString];
        return [NSString stringWithFormat:@"Yesterday %@", [dateLocal stringFromDate:self]];
    }
    
    
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    if(dateString == nil) dateString = @"";
    return dateString;
}


-(NSString*)stringFromDateMonthOnly{
    
    NSString *dateFormatString = @"MMMM";
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    if(dateString == nil) dateString = @"";
    return dateString;
}


-(NSString*)stringFromDateDayOnly{
    
    NSString *dateFormatString = @"MMMM dd, YYYY";
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    if(dateString == nil) dateString = @"";
    return dateString;
}

-(NSString*)stringFromDateDayOnlyShort{
    
    NSString *dateFormatString = @"MMM dd, YYYY HH:mm";
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    if(dateString == nil) dateString = @"";
    return dateString;
}


-(NSString*)stringFromDateFull{
    NSString *dateFormatString = @"EEEE MMMM dd, YYYY";
    
    NSDateFormatter* dateUTC = [[NSDateFormatter alloc] init];
    [dateUTC setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateUTC setDateFormat:dateFormatString];
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    if(dateString == nil) dateString = @"";
    return dateString;
}

-(NSString*)stringFromDate{
    if(self == nil) return @"<nil>";
    if([self isToday]) return @"Today";
    else if([self isTomorrow]) return @"Tomorrow";
    else if([self isYesterday]) return @"Yesterday";
    
    NSString *dateFormatString = @"EEEE, MMMM dd, YYYY";
    
    NSDateFormatter* dateUTC = [[NSDateFormatter alloc] init];
    [dateUTC setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateUTC setDateFormat:dateFormatString];
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    if(dateString == nil) dateString = @"";
    return dateString;
}


-(NSString*)stringFromDateShort{
    if([self isToday]) return @"Today";
    else if([self isTomorrow]) return @"Tomorrow";
    else if([self isYesterday]) return @"Yesterday";
    
    NSString *dateFormatString = @"EE, MMM dd, YYYY";
    
    NSDateFormatter* dateUTC = [[NSDateFormatter alloc] init];
    [dateUTC setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateUTC setDateFormat:dateFormatString];
    
    NSDateFormatter* dateLocal = [[NSDateFormatter alloc] init];
    [dateLocal setTimeZone:[NSTimeZone localTimeZone]];
    [dateLocal setDateFormat:dateFormatString];
    
    NSString* dateString = [dateLocal stringFromDate:self];
    if(dateString == nil) dateString = @"";
    return dateString;
}

-(NSString*)stringRelativeTimeWithFirstLetterUppercase:(BOOL)uppercase {
    
    NSDate *now = [NSDate date];
    double deltaSeconds = fabs([self timeIntervalSinceDate:now]);
    double deltaMinutes = deltaSeconds / 60.0f;
    
    NSUInteger minutes;
    
    NSString* text;
    
    if(self == nil){
        return @"";
    } else if(deltaSeconds < 5) {
        text = @"just now";
    } else if(deltaSeconds < 60) {
        return [NSString stringWithFormat:@"%ld seconds ago", (long)deltaSeconds];
    } else if(deltaSeconds < 120) {
        text = [NSString stringWithFormat:@"a minute ago"];
    } else if (deltaMinutes < 60) {
        return [NSString stringWithFormat:@"%ld minutes ago", (long)deltaMinutes];
    } else if (deltaMinutes < 120) {
        text = [NSString stringWithFormat:@"an hour ago"];
    } else if (deltaMinutes < (24 * 60)) {
        minutes = (NSUInteger)floor(deltaMinutes/60);
        return [NSString stringWithFormat:@"%ld hours ago", (long)minutes];
    } else if (deltaMinutes < (24 * 60 * 2)) {
        return @"Yesterday";
    } else if (deltaMinutes < (24 * 60 * 7)) {
        minutes = (NSUInteger)floor(deltaMinutes/(60 * 24));
        return [NSString stringWithFormat:@"%ld days ago", (long)minutes];
    } else if (deltaMinutes < (24 * 60 * 14)) {
        text = [NSString stringWithFormat:@"last week"];
    } else if (deltaMinutes < (24 * 60 * 31)) {
        minutes = (NSUInteger)floor(deltaMinutes/(60 * 24 * 7));
        return [NSString stringWithFormat:@"%ld weeks ago", (long)minutes];
    } else if (deltaMinutes < (24 * 60 * 61)) {
        text = @"last month";
    } else if (deltaMinutes < (24 * 60 * 365.25)) {
        minutes = (NSUInteger)floor(deltaMinutes/(60 * 24 * 30));
        return [NSString stringWithFormat:@"%ld months ago", (long)minutes];
    } else if (deltaMinutes < (24 * 60 * 731)) {
        text = @"last year";
    }
    
    if (!text) {
        minutes = (NSUInteger)floor(deltaMinutes/(60 * 24 * 365));
        text = [NSString stringWithFormat:@"%ld years ago", (long)minutes];
    }
    
    if (uppercase) {
        NSString *capitalized = [[[text substringToIndex:1] uppercaseString] stringByAppendingString:[text substringFromIndex:1]];
        return capitalized;
    } else {
        return text;
    }
}

-(NSString*)stringRelativeTimeFromDate{
    return [self stringRelativeTimeWithFirstLetterUppercase:YES];
}




@end
