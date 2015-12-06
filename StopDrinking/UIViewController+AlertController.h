//
//  UIViewController+AlertController.h
//  ZH
//
//  Created by Zakk Hoyt on 4/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (AlertController)
-(void)presentAlertDialogWithMessage:(NSString*)message;
-(void)presentAlertDialogWithTitle:(NSString*)title message:(NSString*)message;
-(void)presentAlertDialogWithTitle:(NSString*)title errorAsMessage:(NSError*)error;
@end
