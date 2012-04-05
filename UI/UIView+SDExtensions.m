//
//  UIView+SDExtensions.m
//  walmart
//
//  Created by Sam Grover on 2/27/11.
//  Copyright 2011 Set Direction. All rights reserved.
//

#import "UIView+SDExtensions.h"


@implementation UIView (SDExtensions)

- (void)positionBelowView:(UIView *)argView offset:(CGFloat)argOffset
{
	self.frame = CGRectMake(self.frame.origin.x,
							argView.frame.origin.y + argView.frame.size.height + argOffset,
							self.frame.size.width,
							self.frame.size.height);
}

-(void)setFrameOriginY:(CGFloat)newY
{
	CGRect f = self.frame;
	f.origin.y = newY;
	self.frame = f;
}

-(void)setFrameOriginX:(CGFloat)newX
{
	CGRect f = self.frame;
	f.origin.x = newX;
	self.frame = f;
}

-(void)setIntegralCenter:(CGPoint)integralCenter
{
	CGRect integralFrame = self.frame;
	integralFrame.origin = integralCenter;
	integralFrame = CGRectIntegral(integralFrame);
	self.center = integralFrame.origin;
}

-(CGPoint)integralCenter
{
	CGRect integralFrame = self.frame;
	integralFrame.origin = self.center;
	integralFrame = CGRectIntegral(integralFrame);
	return integralFrame.origin;
}

- (void)setIntegralFrame:(CGRect)viewFrame
{
	self.frame = CGRectIntegral(viewFrame);
}

- (CGRect)integralFrame
{
	return CGRectIntegral(self.frame);
}

@end
