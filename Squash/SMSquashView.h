//
//  SMSquashView.h
//  Squash
//
//  Created by Joel Kraut on 6/30/13.
//  Copyright (c) 2013 Joel Kraut. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMSquashView : UIView

// The minimum velocity (in points per second) above which squashing and stretching will occur.
//
// Default value is 3000, which works well on an iPad screen with the default .25s animation duration.
@property (nonatomic, assign) float squashFactor;

// The upper and lower bounds for distortion. The layer will never scale more than maxStretch in the
// direction of travel, and will never scale less than minSquash in the perpindicular directions.
//
// maxStretch defaults to 2.0; minSquash defaults to 0.5.
@property (nonatomic, assign) float maxStretch;
@property (nonatomic, assign) float minSquash;

@end
