//
//  NSDate+ZH.h
//  ZH
//
//  Created by Zakk Hoyt on 4/20/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZH)

// Date from string
+(NSDate*)dateFromStringDownToTheSecond:(NSString*)string;
+(NSString*)stringForRangeStartDat1:(NSDate*)startDate endDate:(NSDate*)endDate;

// String from date
-(NSString*)stringFromDateDownToTheSecond;
-(NSString*)stringFromDateAndTime;
-(NSString*)stringFromDateMonthOnly;
-(NSString*)stringFromDateDayOnly;
-(NSString*)stringFromDateDayOnlyShort;
-(NSString*)stringFromDateFull;
-(NSString*)stringFromDate;
-(NSString*)stringFromDateShort;
-(NSString*)stringRelativeTimeWithFirstLetterUppercase:(BOOL)uppercase;
-(NSString*)stringRelativeTimeFromDate;


@end
