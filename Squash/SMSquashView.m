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
}
@end

@implementation SMSquashView

+ (Class)layerClass
{
	return [SMSquashLayer class];
}

- (id < CAAction >)actionForLayer:(CALayer *)layer forKey:(NSString *)key
{
	id <CAAction> parent = [super actionForLayer:layer forKey:key];
	if ([key isEqualToString:@"position"])
	{
		if ([(NSObject*)parent conformsToProtocol:@protocol(CAMediaTiming)])
			positionDuration = ((id<CAMediaTiming>)parent).duration;
		return parent;
	}
	else if ([key isEqualToString:kSquashActionKey])
	{
		id <CAAction> mine = [[self.layer class] defaultActionForKey:key];
		if ([(NSObject*)mine conformsToProtocol:@protocol(CAMediaTiming)] && positionDuration)
			((id<CAMediaTiming>)mine).duration = positionDuration;
		positionDuration = 0;
		return mine;
	}
	return parent;
}

@end
