//
//  SMSquashView.m
//  Squash
//
//  Created by Joel Kraut on 6/30/13.
//  Copyright (c) 2013 Joel Kraut. All rights reserved.
//

#import "SMSquashView.h"
#import "SMSquashLayer.h"

@interface SMSquashView () {
	CFTimeInterval positionDuration;
	BOOL positionAnimates;
}
@end

@implementation SMSquashView

@dynamic squashFactor, maxStretch, minSquash, smoothMotion;

+ (Class)layerClass
{
	return [SMSquashLayer class];
}

// by using our layer's delegate methods, we can get and set all the information we need
- (id < CAAction >)actionForLayer:(CALayer *)layer forKey:(NSString *)key
{
	id <CAAction> parent = [super actionForLayer:layer forKey:key];
	
	// If the position is changing and it's animated, that means it was changed inside an animation block.
	// We can take the duration of that animation and apply it to our custom animator's action.
	if ([key isEqualToString:@"position"])
	{
		positionAnimates = YES;
		if ([(NSObject*)parent conformsToProtocol:@protocol(CAMediaTiming)])
			positionDuration = ((id<CAMediaTiming>)parent).duration;
		else
			positionAnimates = NO;
		return parent;
	}
	// Here we apply the position animation's duration to the squash action, which we get from our layer.
	else if ([key isEqualToString:kSquashActionKey])
	{
		id <CAAction> mine = [[self.layer class] defaultActionForKey:key];
		if ([(NSObject*)mine conformsToProtocol:@protocol(CAMediaTiming)] && positionDuration)
			((id<CAMediaTiming>)mine).duration = positionDuration;
		positionDuration = 0;
		if (positionAnimates)
			return mine;
		return parent;
	}
	return parent;
}

// pass through layer properties

- (float)squashFactor
{
	return ((SMSquashLayer*)self.layer).squashFactor;
}

- (float)maxStretch
{
	return ((SMSquashLayer*)self.layer).maxStretch;
}

- (float)minSquash
{
	return ((SMSquashLayer*)self.layer).minSquash;
}

- (BOOL)smoothMotion
{
	return ((SMSquashLayer*)self.layer).smoothMotion;
}

- (void)setSquashFactor:(float)squashFactor
{
	((SMSquashLayer*)self.layer).squashFactor = squashFactor;
}

- (void)setMaxStretch:(float)maxStretch
{
	((SMSquashLayer*)self.layer).maxStretch = maxStretch;
}

- (void)setMinSquash:(float)minSquash
{
	((SMSquashLayer*)self.layer).minSquash = minSquash;
}

- (void)setSmoothMotion:(BOOL)smoothMotion
{
	((SMSquashLayer*)self.layer).smoothMotion = smoothMotion;
}

@end
