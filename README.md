# Squash

Automatic squash/stretch animated subclasses of UIView and CALayer.

SMSquashView and its backing class, SMSquashLayer, squash and stretch themselves automatically in response to motion. They will distort themselves longer in the direction of motion, and shorter in the perpendicular directions. The distortion is proportional to the velocity the object, and scaled such that the volume remains constant. In short: it does exactly what you’d want it to do, with no configuration required.

## How It Works

The math is pretty simple, if you like transformation matrices. Every time the layer’s position changes, we note the time and position delta from last time. Using that information we can calculate the velocity for the current frame of animation. We align a transformation matrix to the direction of travel using the same idea as gluLookAt, then scale according to the magnitude of the velocity.

## How to Use It

Seriously, just drop it in. It supports all the customization you could want:
* `squashFactor` represents the speed above which an object must move to be distorted
* `maxStretch` puts a ceiling on the amount of stretching an object can do
* `minSquash` puts a floor on it
* `smoothMotion` will run a moving average filter to smooth out motion jaggies
…but these are all set to very reasonable values. You may not need to change them.

## What's It Look Like

![Squash Demo GIF](http://blog.spacemanlabs.com/wp-content/uploads/2013/07/squash.gif)

## More Info

The original blog post for this project can be found [here](http://blog.spacemanlabs.com/?p=684).


LICENSE
-------

Copyright (C) 2013 by Spaceman Labs

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
