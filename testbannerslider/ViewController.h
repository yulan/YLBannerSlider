//
//  ViewController.h
//  testbannerslider
//
//  Created by lan yu on 19/05/2014.
//  Copyright (c) 2014 lan yu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLSliderBannerView.h"

///--------------------------
/// @name ViewController
///--------------------------
/**
 * view controller to represent the banner slider with the delegate YLSliderBannerViewDelegate
 */
@interface ViewController : UIViewController <YLSliderBannerViewDelegate, UITextFieldDelegate,UIAlertViewDelegate>

@end
