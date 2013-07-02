//
//  ViewController.m
//  fiatlux
//
//  Created by Joel Kraut on 3/14/12.
//  Copyright (c) 2012 Spaceman Labs. All rights reserved.
//

#import "SMViewController.h"
#import "SMSquashView.h"
#import "SMSquashLayer.h"

// If none of these defines are enabled, a tap will cause a basic
// animation from the view's current position to the tap location.
// A pan gesture will drag the view.
//
// Probably at most one of these defines should be enabled.

// If USE_DYNAMICS is defined, a tap will snap the view to that point.
// A pan will remove the snap and allow gravity to take its course.
//#define USE_DYNAMICS

// if USE_SPRING_ANIMATION is defined, the view will animate to the tap
// position with springiness.
#define USE_SPRING_ANIMATION

// if USE_CALAYER is defined, an SMSquashLayer will be used, rather than
// an SMSquashView. Because dynamics and spring-style animations both
// require UIViews, interaction will be the same as if no defines were
// enabled, but with a layer rather than a view.
//#define USE_CALAYER

@interface SMViewController ()
{
	SMSquashLayer *layer;
	SMSquashView *view;
	
	UIDynamicAnimator *animator;
	UISnapBehavior *snap;
}
@end

@implementation SMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	CATransform3D perspective = CATransform3DIdentity;
	perspective.m34 = -1.f/1000.f;
	self.view.layer.sublayerTransform = perspective;
	self.view.backgroundColor = [UIColor grayColor];
	
	CGSize viewSize = self.view.bounds.size;

	UIImage *image = [UIImage imageNamed:@"logo_periwinkle"];
	
#ifdef USE_CALAYER
	layer = [[SMSquashLayer alloc] init];
	layer.frame = CGRectMake(viewSize.width/2 - 150, viewSize.height/2 - 150, 300, 300);
	[self.view.layer addSublayer:layer];
	layer.contents = (id)image.CGImage;
#else
	view = [[SMSquashView alloc] init];
	view.frame = CGRectMake(viewSize.width/2 - 150, viewSize.height/2 - 150, 300, 300);
	[self.view addSubview:view];
	view.layer.contents = (id)image.CGImage;
#endif
	
	// dynamics
#if defined(USE_DYNAMICS) && !defined(USE_CALAYER)
	animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[view]];
	collision.translatesReferenceBoundsIntoBoundary = YES;
	[animator addBehavior:collision];
	UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[view]];
	[animator addBehavior:gravity];
	
	// tweak values to show off the squash
	view.squashFactor = 750;
	view.smoothMotion = YES;
#endif
	
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
	[self.view addGestureRecognizer:pan];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[self.view addGestureRecognizer:tap];
}

- (void)pan:(UIPanGestureRecognizer*)pan
{
#ifdef USE_DYNAMICS
	if (snap)
		[animator removeBehavior:snap];
	snap = nil;
#else
	CGPoint location = [pan locationInView:self.view];
	layer.position = location;
	view.center = location;
#endif
}

- (void)tap:(UITapGestureRecognizer*)tap
{
	CGPoint location = [tap locationInView:self.view];
#ifndef USE_CALAYER
#ifdef USE_DYNAMICS
	if (snap)
		[animator removeBehavior:snap];
	snap = [[UISnapBehavior alloc] initWithItem:view snapToPoint:location];
	[animator addBehavior:snap];
#elif defined(USE_SPRING_ANIMATION)
	[UIView animateWithDuration:1./3. delay:0 usingSpringWithDamping:.5f initialSpringVelocity:20.f options:0 animations:^{
		view.center = location;
	} completion:nil];
#else
	[UIView animateWithDuration:1./3. animations:^{
		view.center = location;
	}];
#endif
#else
	[CATransaction begin];
	[CATransaction setAnimationDuration:1./3.];
	layer.position = location;
	[CATransaction commit];
#endif
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
