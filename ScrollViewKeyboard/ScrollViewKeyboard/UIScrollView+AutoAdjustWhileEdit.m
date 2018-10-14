//
//  UIScrollView+AutoAdjustWhileEdit.m
//  ScrollViewKeyboard
//
//  Created by zhouke on 2018/10/13.
//  Copyright © 2018年 zhouke. All rights reserved.
//

#import "UIScrollView+AutoAdjustWhileEdit.h"
#import "UIResponder+FirstResponder.h"
#import <objc/runtime.h>

static NSString * const kAutoAdjustSwitchKey = @"AutoAdjustSwitchKey";

@implementation UIScrollView (AutoAdjustWhileEdit)

- (void)setIsAutoAdjust:(BOOL)isAutoAdjust
{
    objc_setAssociatedObject(self, &kAutoAdjustSwitchKey, @(isAutoAdjust), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (isAutoAdjust) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillShow:)
                                                     name:UIKeyboardWillShowNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(keyboardWillHide:)
                                                     name:UIKeyboardWillHideNotification
                                                   object:nil];
    } else {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (BOOL)isAutoAdjust
{
    return [objc_getAssociatedObject(self, &kAutoAdjustSwitchKey) boolValue];
}

- (void)keyboardWillShow:(NSNotification *)notice
{
    if (!self.isAutoAdjust) return;
    
    NSValue *aValue = [notice.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat keyboardHeigth = keyboardRect.size.height;
    
    UIView *textField = [UIResponder getCurrentFirstResponder];
    CGRect textFieldFrame = [self convertRect:textField.frame fromView:textField.superview];
    CGFloat maxY = CGRectGetMaxY(textFieldFrame);
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    CGRect selfRect = [keyWindow convertRect:self.frame fromView:self.superview];
    // scrollView 距屏幕底部的间距
    CGFloat bottomMarge = keyWindow.frame.size.height - CGRectGetMaxY(selfRect);
    
    CGFloat coverHeight = keyboardHeigth - bottomMarge;
    CGFloat adjustContentOffsetY = coverHeight + maxY - self.frame.size.height;
    
    if (self.contentOffset.y < adjustContentOffsetY ) {
        [self setContentOffset:CGPointMake(0, adjustContentOffsetY) animated:NO];
    }
}

- (void)keyboardWillHide:(NSNotification *)notice
{
    if (!self.isAutoAdjust) return;
    
    if (self.contentOffset.y > self.contentSize.height - self.frame.size.height) {
        [self setContentOffset:CGPointMake(0, self.contentSize.height - self.frame.size.height) animated:YES];
    }
}

@end
