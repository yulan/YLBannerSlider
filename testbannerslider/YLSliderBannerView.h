//
// YLSliderBannerView.h
//  testbannerslider
//
//  Created by Lan Yu on 20/05/2014.
//  Copyright (c) 2014 lan yu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YLSliderBannerView;

///----------------------------------
/// @name YLSliderBannerViewDelegate
///----------------------------------

/**
 * The `YLSliderBannerViewDelegate` protocol is adopted by an object that wants to be return the instant,
 * set speed and distance.
 */

@protocol YLSliderBannerViewDelegate <NSObject>

///---------------------
/// @name Related
///---------------------

@required
/**
 * Return instant
 */
-(UIView *)viewForSlider:(YLSliderBannerView *)view;
@optional
/**
 * Set distance
 */
-(CGFloat)distanceForSlider:(YLSliderBannerView *)view;
/**
 * Set speed
 */
-(CGFloat)speedForSlider:(YLSliderBannerView *)view;

@end;

///--------------------------
/// @name YLSliderBannerView
///--------------------------
/**
 * clsse to represent the banner slider
 */
@interface YLSliderBannerView : UIView <UIAlertViewDelegate>
/**
 * delegate to return the instant
 */
@property(nonatomic) id <YLSliderBannerViewDelegate> delegate;
/**
 * to represent the banner slider
 */
-(void)reload;
/**
 * to stop the banner slider
 */
-(void)stop;

@end
