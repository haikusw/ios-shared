//
//  SDAutolayoutStackView.m
//  StackedContainerViewDemo
//
//  Created by Tim Trautmann on 1/28/14.
//  Copyright (c) 2014 SetDirection All rights reserved.
//

#import "SDAutolayoutStackView.h"

@interface SDAutolayoutStackView ()
@property (nonatomic, strong) NSLayoutConstraint *lastConstraint;
@property (nonatomic, strong) UIView *lastView;
@end

@implementation SDAutolayoutStackView

- (void)didAddSubview:(UIView *)subview
{
    [super didAddSubview:subview];
    [self addConstraintsForSubview:subview];
}

- (void)willRemoveSubview:(UIView *)subview
{
    [super willRemoveSubview:subview];
    BOOL isVertical = self.orientation == SDAutolayoutStackViewOrientationVertical;
    // if there will be remaining subviews
    if (self.subviews.count > 1) {
        NSUInteger index = [self.subviews indexOfObject:subview];
        // if we are removing the first subview
        if (index == 0) {
            // find the new top and connect it
            UIView *newTop = self.subviews[1];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:newTop
                                                             attribute:isVertical ? NSLayoutAttributeTop : NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:isVertical ? NSLayoutAttributeTop : NSLayoutAttributeLeading
                                                            multiplier:1.0
                                                              constant:isVertical ? self.edgeInsets.top : self.edgeInsets.left]];

            
        // if we are removing the last one
        } else if (index == self.subviews.count - 1) {
            // find the previous one and connect it to the bottom
            self.lastView = self.subviews[index - 1];
            self.lastConstraint = [NSLayoutConstraint constraintWithItem:self.lastView
                                                               attribute:isVertical ? NSLayoutAttributeBottom : NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:isVertical ? NSLayoutAttributeBottom : NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:isVertical ? -self.edgeInsets.bottom : -self.edgeInsets.right];
            [self addConstraint:self.lastConstraint];
        // removing a middle subview
        } else {
            // connect the previous and next subviews
            UIView *previousView = self.subviews[index - 1];
            UIView *nextView = self.subviews[index + 1];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:nextView
                                                             attribute:isVertical ? NSLayoutAttributeTop : NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:previousView
                                                             attribute:isVertical ? NSLayoutAttributeBottom : NSLayoutAttributeTrailing
                                                            multiplier:1.0
                                                              constant:self.gap]];
        }
    } else {
        self.lastView = nil;
    }
}

- (void) addConstraintsForSubview:(UIView *)view {
    switch (self.orientation) {
        case SDAutolayoutStackViewOrientationVertical:
        {
            // If this is the first (topmost) view, attach it to the parent view at the top.
            if (!self.lastView)
            {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeTop
                                                                multiplier:1.0
                                                                  constant:self.edgeInsets.top]];
            }
            // Otherwise attach this view to the previous view's bottom.
            else
            {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeTop
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.lastView
                                                                 attribute:NSLayoutAttributeBottom
                                                                multiplier:1.0
                                                                  constant:self.gap]];
            }
            
            // All child views have leading and trailing constraints.
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(left)-[view]-(right)-|"
                                                                         options:0
                                                                         metrics:@{ @"left" : @(self.edgeInsets.left),
                                                                                    @"right" : @(self.edgeInsets.right) }
                                                                           views:NSDictionaryOfVariableBindings(view)]];
            
            // If there is already a last constraint, remove it.
            if (self.lastConstraint)
                [self removeConstraint:self.lastConstraint];
            
            
            // Add the last constraint to attach view to the bottom of container
            // view.
            self.lastConstraint = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeBottom
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeBottom
                                                              multiplier:1.0
                                                                constant:-self.edgeInsets.bottom];
            
            [self addConstraint:self.lastConstraint];
            self.lastView = view;

            break;
        }
        case SDAutolayoutStackViewOrientationHorizontal:
        {
            // If this is the first (leading) view, attach it to the parent view's leading side.
            if (!self.lastView)
            {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self
                                                                 attribute:NSLayoutAttributeLeading
                                                                multiplier:1.0
                                                                  constant:self.edgeInsets.left]];
            }
            // Otherwise attach this view to the previous view's trailing side.
            else
            {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                 attribute:NSLayoutAttributeLeading
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.lastView
                                                                 attribute:NSLayoutAttributeTrailing
                                                                multiplier:1.0
                                                                  constant:self.gap]];
            }
            
            // All child views have top and bottom constraints.
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(top)-[view]-(bottom)-|"
                                                                         options:0
                                                                         metrics:@{ @"top" : @(self.edgeInsets.top),
                                                                                    @"bottom" : @(self.edgeInsets.bottom) }
                                                                           views:NSDictionaryOfVariableBindings(view)]];
            
            // If there is already a last constraint, remove it.
            if (self.lastConstraint)
                [self removeConstraint:self.lastConstraint];
            
            
            // Add the last constraint to attach view to the trailing edge of container
            // view.
            self.lastConstraint = [NSLayoutConstraint constraintWithItem:view
                                                               attribute:NSLayoutAttributeTrailing
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self
                                                               attribute:NSLayoutAttributeTrailing
                                                              multiplier:1.0
                                                                constant:-self.edgeInsets.right];
            
            [self addConstraint:self.lastConstraint];
            self.lastView = view;
            
            break;
        }
        default:
            break;
    }
    

}

@end
