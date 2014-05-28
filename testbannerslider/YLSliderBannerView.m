//
//  YLSliderBannerView.m
//  testbannerslider
//
//  Created by Lan Yu on 20/05/2014.
//  Copyright (c) 2014 lan yu. All rights reserved.
//

#import "YLSliderBannerView.h"
#import <QuartzCore/QuartzCore.h>


/**
 A string to represent the log banner slider
 */
#if defined(ENABLE_LOG_BANNERSLIDERVIEW)
#define _LOG_BANNERSLIDERVIEW _LOG
#else
#define _LOG_BANNERSLIDERVIEW(...) {;}
#endif

/* speed default*/
static const CGFloat SPEED = 50;
/* distance default*/
static const CGFloat DISTANCE = 20;

@interface YLSliderBannerView()
{
    CGFloat _speed;
    CGFloat _distance;
    
    UIView *_view1;
    UIView *_view2;
}

@end

///--------------------------
/// @name YLSliderBannerView
///--------------------------
/**
 * clsse to represent the banner slider
 */
@implementation YLSliderBannerView

#pragma mark - animations
/**
 *  second banner first show with a delay
 */
-(void)animate1
{    
    CGFloat startingX = _view2.frame.size.width;
    CGFloat endX = - _view2.frame.size.width;
    
	float duration = _view2.frame.size.width/ _speed;
    float delay = _distance/_speed+duration*0.5;
    
        [_view2 setFrame:CGRectMake(startingX, _view2.frame.origin.y, _view2.frame.size.width, _view2.frame.size.height)];
        [_view2 setBackgroundColor:[UIColor blackColor]];
    
        [UIView animateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:^{
            // Update end position
            CGRect bannerFrame = _view2.frame;
            bannerFrame.origin.x = endX;
            [_view2 setFrame:bannerFrame];}
                         completion:^(BOOL finished) {
                             if (!finished) {
                                 return ;
                             }else [self animate3];
                         }];

}
/**
 *  second banner show with a delay in boucle
 */
-(void)animate3
{
    CGFloat startingX = _view2.frame.size.width;
    CGFloat endX = - _view2.frame.size.width;
    
    
	float duration = _view2.frame.size.width/_speed;
    float delay = _distance/_speed;
        
        [_view2 setFrame:CGRectMake(startingX, _view2.frame.origin.y, _view2.frame.size.width, _view2.frame.size.height)];
        
        [UIView animateWithDuration:duration delay:delay*2 options:UIViewAnimationOptionCurveLinear animations:^{
            // Update end position
            CGRect bannerFrame = _view2.frame;
            bannerFrame.origin.x = endX;
            [_view2 setFrame:bannerFrame];}
                         completion:^(BOOL finished) {
                             if (!finished) {
                                 return ;
                             } else [self animate3];
                         }];
}

/**
 *  first banner first show
 */
-(void)animate2
{
    CGFloat startingX = _view1.frame.size.width;
    CGFloat endX = - _view1.frame.size.width;
    
	float duration = _view1.frame.size.width/_speed;
        
        [_view1 setFrame:CGRectMake(startingX, _view1.frame.origin.y, _view1.frame.size.width, _view1.frame.size.height)];
        [_view1 setBackgroundColor:[UIColor redColor]];
        
        [UIView animateWithDuration:duration delay:0.0f options:UIViewAnimationOptionCurveLinear animations:^{
            // Update end position
            CGRect bannerFrame = _view1.frame;
            bannerFrame.origin.x = endX;
            [_view1 setFrame:bannerFrame];}
                         completion:^(BOOL finished) {
                             if (!finished) {
                                 return ;
                             }else [self animate4];
                         }];
   
}
/**
 *  First banner show with a delay in boucle
 */
-(void)animate4
{
    CGFloat startingX = _view1.frame.size.width;
    CGFloat endX = - _view1.frame.size.width;
    
	float duration = _view1.frame.size.width/_speed;
    float delay = _distance/_speed;
    
        [_view1 setFrame:CGRectMake(startingX, _view1.frame.origin.y, _view1.frame.size.width, _view1.frame.size.height)];
        [_view1 setBackgroundColor:[UIColor redColor]];
        
        [UIView animateWithDuration:duration delay:delay*2 options:UIViewAnimationOptionCurveLinear animations:^{
            // Update end position
            CGRect bannerFrame = _view1.frame;
            bannerFrame.origin.x = endX;
            [_view1 setFrame:bannerFrame];}
                         completion:^(BOOL finished) {
                             if (!finished) {
                                 return ;
                             }
                             else [self animate4];
                         }];
}

#pragma mark - reload
/**
 *  reload with 2 view with or without parametres speed and distance
 */
-(void)reload
{
    [self stop];
    
    /**
     *  check all delegates, get back the instant and set speed and distance 
     */
    if (self.delegate != nil){

        if ([self.delegate respondsToSelector:@selector(viewForSlider:)]) {
            _view1 =[self.delegate viewForSlider:self];
            _view2 =[self.delegate viewForSlider:self];
        }else{
            _LOG_BANNERSLIDERVIEW(@"[self.delegate viewForSlider:self] not exec");
            return;
        }
        
        if ([self.delegate respondsToSelector:@selector(speedForSlider:)]&&([self.delegate speedForSlider:self] !=-1)){
             _speed = [self.delegate speedForSlider:self];
            
        } else {
            _speed = SPEED;
            _LOG_BANNERSLIDERVIEW(@"[self.delegate speedForSlider:self] not exec");
        }
        
        if ([self.delegate respondsToSelector:@selector(distanceForSlider:)]&&([self.delegate distanceForSlider:self] !=-1)){
            _distance = [self.delegate distanceForSlider:self];
        } else {
            _distance = DISTANCE;
            _LOG_BANNERSLIDERVIEW(@"[self.delegate distanceForSlider:self] not exec");
        }

    } else {
        _LOG_BANNERSLIDERVIEW(@"self.delegate == nil");
        return;
    }
    
    if (_speed<10 || _speed>100|| _distance<10 || _distance>100) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Speed or distance is not correct"
                                                        message:@"Reset, please"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    /**
     *  Show slide with 2 views if it's more large than super view
     */
    if (_view1.frame.size.width > self.frame.size.width) {
        [self addSubview:_view1];
        [self addSubview:_view2];

        [self animate1];
        [self animate2];
    }
    /**
     *  show 1 view in centre
     */
    else{
        [self addSubview:_view1];
        [_view1 setFrame:CGRectMake((self.frame.size.width-_view1.frame.size.width)/2, _view1.frame.origin.y, _view1.frame.size.width, _view1.frame.size.height)];
    }
}


/**
 *  stop all animation
 */
-(void)stop
{
    [_view1.layer removeAllAnimations];
    [_view2.layer removeAllAnimations];
    [_view1 removeFromSuperview];
    [_view2 removeFromSuperview];
}

@end
