//
//  SMSquashView.m
//  Squash
//
//  Created by Joel Kraut on 6/30/13.
//  Copyright (c) 2013 Joel Kraut. All rights reserved.
//

#import "SMSquashView.h"
#import "SMSquashLayer.h"

@implementation SMSquashView

+ (Class)layerClass
{
	return [SMSquashLayer class];
}

- (id < CAAction >)actionForLayer:(CALayer *)layer forKey:(NSString *)key
{
	return [[self.layer class] defaultActionForKey:key];
}

@end
