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
//	layer = [[SMSquashLayer alloc] init];
	view = [[SMSquashView alloc] init];
	layer.frame = CGRectMake(viewSize.width/2 - 150, viewSize.height/2 - 150, 300, 300);
	view.frame = CGRectMake(viewSize.width/2 - 150, viewSize.height/2 - 150, 300, 300);
	[self.view.layer addSublayer:layer];
	[self.view addSubview:view];
	
	UIImage *image = [UIImage imageNamed:@"logo_periwinkle"];
	layer.contents = (id)image.CGImage;
	view.layer.contents = (id)image.CGImage;
	
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
	[UIView animateWithDuration:1.f animations:^{
		view.center = location;
	}];
	[CATransaction begin];
	[CATransaction setAnimationDuration:1./3.];
	layer.position = location;
	[CATransaction commit];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
