//
//  UIColor+Shorthands.m
//  TestBudget
//
//  Created by vlad on 08/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import "UIColor+Shorthands.h"

@implementation UIColor (Shorthands)

+ (UIColor *)r:(CGFloat)red g:(CGFloat)green b:(CGFloat)blue {
    static CGFloat d  = 255.0;
    return [UIColor colorWithRed:red / d green:green / d blue:blue / d alpha:1.0];
}

+ (UIColor *)TBlueColor {
    return [UIColor r:56.0 g:143.0 b:205.0];
}

@end
