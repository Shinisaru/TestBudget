//
//  SHButton.m
//  TestBudget
//
//  Created by vlad on 09/04/15.
//  Copyright (c) 2015 Avast. All rights reserved.
//

#import "SHButton.h"
#import <QuartzCore/QuartzCore.h>

@interface SHButton()

- (void)animateBG:(UIColor *)withColor;
- (void)resetHighlight;

@end

@implementation SHButton

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    [self animateBG:self.hightlightBackgroundColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self resetHighlight];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    [self resetHighlight];
}

- (void)resetHighlight {
    [self animateBG:self.selected ? self.selectedBackgroundColor : self.defaultBackgroundColor];
}

- (void)animateBG:(UIColor *)withColor {
    CATransition *animation = [CATransition new];
    animation.type = kCATransitionFade;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.layer addAnimation:animation forKey:@"EaseOut"];
    self.backgroundColor = withColor;
}

@end
