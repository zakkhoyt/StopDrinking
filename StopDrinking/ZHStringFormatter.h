//
//  ZHStringFormatter.h
//  StopDrinking
//
//  Created by Zakk Hoyt on 12/6/15.
//  Copyright © 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZHStringFormatter : NSObject

+(NSAttributedString*)formattedStringForString:(NSString*)bodyHTML;
@end
