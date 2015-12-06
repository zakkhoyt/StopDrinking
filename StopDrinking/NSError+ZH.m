//
//  NSError+ZH.m
//  ZH
//
//  Created by Zakk Hoyt on 4/27/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "NSError+ZH.h"

@implementation NSError (ZH)
+(NSError*)zhError{
    return [NSError zhErrorWithCode:NSErrorZHCodeGeneral];
}
+(NSError*)zhErrorWithCode:(NSErrorZHCode)code{
    return [NSError zhErrorWithCode:code userInfo:nil];
}
+(NSError*)zhErrorWithCode:(NSErrorZHCode)code userInfo:(NSDictionary*)userInfo{
    return [NSError errorWithDomain:NSErrorZHDomain code:code userInfo:userInfo];
}
+(NSError*)zhErrorWithCode:(NSErrorZHCode)code localizedFailureReason:(NSString*)localizedFailureReason{
    return [NSError zhErrorWithCode:code userInfo:@{NSLocalizedDescriptionKey: localizedFailureReason}];
}

+(NSString*)stringFromCode:(NSErrorZHCode)code{
    switch (code){
        case NSErrorZHCodeGeneral:
            return @"General error";
        case NSErrorZHCodeUserCancelled:
            return @"User cancelled";
        case NSErrorZHCodeInvalidSelection:
            return @"Invalid selection";
        case NSErrorZHCodeStackShareFailed:
            return @"Share failed";
        case NSErrorZHCodeNotImplemented:
            return @"Funcionality not implemented (TODO)";
            default:
            return @"Unknown";
            

    }
}
@end
