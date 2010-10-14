//
//  ImageScrollView.m
//  EasyGallery
//
//  Created by Hiroshi Hashiguchi on 10/10/04.
//  Copyright 2010 . All rights reserved.
//

#import "XCGalleryInnerScrollView.h"


@implementation XCGalleryInnerScrollView

@synthesize imageView = imageView_;

-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
	return [self.subviews objectAtIndex:0];
}


-(id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
		
		// setup scrollview
//		[self setUserInteractionEnabled:YES];
		self.delegate = self;
		self.minimumZoomScale = 1.0;
		self.maximumZoomScale = 5.0;
		self.showsHorizontalScrollIndicator = NO;
		self.showsVerticalScrollIndicator = NO;
		self.backgroundColor = [UIColor blackColor];
		self.clipsToBounds = YES;
		
		// setup imageview
		self.imageView =
			[[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
		self.imageView.autoresizingMask =
			UIViewAutoresizingFlexibleLeftMargin  |
			UIViewAutoresizingFlexibleWidth       |
			UIViewAutoresizingFlexibleRightMargin |
			UIViewAutoresizingFlexibleTopMargin   |
			UIViewAutoresizingFlexibleHeight      |
			UIViewAutoresizingFlexibleBottomMargin;		
		self.imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:self.imageView];		
	}
	return self;
}


+ (CGRect)zoomRectForScrollView:(UIScrollView *)scrollView
					  withScale:(float)scale withCenter:(CGPoint)center {
	
    CGRect zoomRect;
    zoomRect.size.height = scrollView.frame.size.height / scale;
    zoomRect.size.width  = scrollView.frame.size.width  / scale;
	zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
	
    return zoomRect;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch* touch = [touches anyObject];
	if ([touch tapCount] == 2) {
		CGRect zoomRect;
		if (self.zoomScale > 1.0) {
			zoomRect = self.bounds;
		} else {
			zoomRect = [XCGalleryInnerScrollView zoomRectForScrollView:self
													withScale:2.0
												   withCenter:[touch locationInView:self]];
		}
		[self zoomToRect:zoomRect animated:YES];
	}
	
//		NSLog(@"offset: %@", NSStringFromCGPoint(self.contentOffset));
}

- (void) dealloc
{
	self.imageView = nil;
	[super dealloc];
}


@end
