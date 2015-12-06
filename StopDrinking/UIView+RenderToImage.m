//
//  UIView+RenderToImage.m
//  ZH
//
//  Created by Zakk Hoyt on 5/18/15.
//  Copyright (c) 2015 Zakk Hoyt. All rights reserved.
//

#import "UIView+RenderToImage.h"

@implementation UIView (RenderToImage)
-(UIImage*)imageRepresentation{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
