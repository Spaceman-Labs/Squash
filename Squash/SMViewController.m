//
//  SMViewController.m
//  Squash
//
//  Created by Joel Kraut on 6/30/13.
//  Copyright (c) 2012 Spaceman Labs. All rights reserved.
//

#import "SMViewController.h"
#import "SMSquashView.h"
#import "SMSquashLayer.h"

// if USE_CALAYER is defined, an SMSquashLayer will be used, rather than
// an SMSquashView. Because dynamics and spring-style animations both
// require UIViews, interaction will be the same as if no defines were
// enabled, but with a layer rather than a view.
//#define USE_CALAYER

@interface SMViewController ()
{
	SMSquashLayer *layer;
	SMSquashView *view;
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
		
	UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
	[self.view addGestureRecognizer:pan];
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
	[self.view addGestureRecognizer:tap];
}

- (void)pan:(UIPanGestureRecognizer*)pan
{
	CGPoint location = [pan locationInView:self.view];
	layer.position = location;
	view.center = location;
}

- (void)tap:(UITapGestureRecognizer*)tap
{
	CGPoint location = [tap locationInView:self.view];
#ifndef USE_CALAYER
	[UIView animateWithDuration:1./3. animations:^{
		view.center = location;
	}];
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
