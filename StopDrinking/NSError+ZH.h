//
//  NSError+ZH.h
//  ZH
//
//  Created by Zakk Hoyt on 4/27/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *NSErrorZHDomain = @"ZH";

typedef enum  {
    NSErrorZHCodeGeneral = -10001,
    NSErrorZHCodeUserCancelled = -10002,
    NSErrorZHCodeInvalidSelection = -10003,
    NSErrorZHCodeStackShareFailed = -10004,
    NSErrorZHCodeAssetUploadFailed = -10005,
    
    NSErrorZHCodeContactAccess = -11000,
    
    NSErrorZHCodeAuthenticaion = -12000,
    
    NSErrorZHCodePreviouslyUploaded = 0x1000,
    NSErrorZHCodeError = 0xFFFF,
    NSErrorZHCodeNotImplemented = -20000,
} NSErrorZHCode;


@interface NSError (ZH)

+(NSError*)zhError;
+(NSError*)zhErrorWithCode:(NSErrorZHCode)code;
+(NSError*)zhErrorWithCode:(NSErrorZHCode)code localizedFailureReason:(NSString*)localizedFailureReason;
+(NSError*)zhErrorWithCode:(NSErrorZHCode)code userInfo:(NSDictionary*)userInfo;




@end
