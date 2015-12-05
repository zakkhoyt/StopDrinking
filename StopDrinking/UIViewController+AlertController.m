//
//  UIViewController+AlertController.m
//  ZH
//
//  Created by Zakk Hoyt on 4/21/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "UIViewController+AlertController.h"

@implementation UIViewController (AlertController)

-(void)presentAlertDialogWithMessage:(NSString*)message{
    [self presentAlertDialogWithTitle:nil message:message];
}

-(void)presentAlertDialogWithTitle:(NSString*)title message:(NSString*)message{
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [ac addAction:[UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleDefault handler:NULL]];
    [self presentViewController:ac animated:YES completion:NULL];
}

-(void)presentAlertDialogWithTitle:(NSString*)title errorAsMessage:(NSError*)error{
    if(error.userInfo[@"NSLocalizedDescription"]) {
        NSString *string = error.userInfo[@"NSLocalizedDescription"];
        [self presentAlertDialogWithTitle:nil message:string];
    } else {
        [self presentAlertDialogWithTitle:nil message:error.userInfo.allValues.description];
    }
}

@end
