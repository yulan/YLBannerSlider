//
//  ViewController.m
//  testbannerslider
//
//  Created by lan yu on 19/05/2014.
//  Copyright (c) 2014 lan yu. All rights reserved.
//

#import "ViewController.h"
#import "YLSliderBannerView.h"

///--------------------------
/// @name ViewController
///--------------------------

@interface ViewController ()

@property (nonatomic, strong) YLSliderBannerView *messengerHeaderView;
@property (nonatomic, strong) IBOutlet UITextField * speedTextField;
@property (nonatomic, strong) IBOutlet UITextField * distanceTextField;

@property (nonatomic, strong) IBOutlet UILabel * speedLabel;
@property (nonatomic, strong) IBOutlet UILabel * distanceLabel;

@property (nonatomic, strong) IBOutlet UIButton *reloadButton;
@property (nonatomic, strong) IBOutlet UIButton *stopButton;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /**
     *  Initiation of banner slider
     */
    self.messengerHeaderView = [[YLSliderBannerView alloc]init];
    [self.messengerHeaderView setFrame:CGRectMake(0, 50, self.view.frame.size.width, 100)];
    self.messengerHeaderView.delegate = self;
    [self.messengerHeaderView reload];
    [self.view addSubview:self.messengerHeaderView];
    
    self.distanceLabel.text = @"distance = 20";
    self.speedLabel.text = @"speed = 50,";
    
    self.speedTextField.delegate = self;
    self.distanceTextField.delegate = self;

}

#pragma delegate for textField
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return  YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.stopButton setEnabled:NO];
    [self.reloadButton setEnabled:NO];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.text.length == 0) {
        [self.stopButton setEnabled:YES];
        [self.reloadButton setEnabled:YES];
    }
}

#pragma delegate YLSliderBannerView
/**
 *  get back a view from any view if call from Banner slider
 *
 *  @param view YLSliderBannerView
 *
 *  @return UIView
 */
-(UIView *)viewForSlider:(YLSliderBannerView*)view
{    
    if (view == self.messengerHeaderView ) {
        
        NSArray *nibViews=[[NSBundle mainBundle] loadNibNamed:@"contenu" owner:self options:nil];
        UIView *newView  =[nibViews objectAtIndex:0];
        return newView;
    }
    else return nil;
}
/**
 *  to set distance
 *
 *  @param view YLSliderBannerView
 *
 *  @return distance to banner slider
 */
-(CGFloat)distanceForSlider:(YLSliderBannerView *)view
{
    if (view == self.messengerHeaderView && self.distanceTextField.text.length!=0) {
         return [self.distanceTextField.text integerValue];
    }
    else return -1;
}
/**
 *  to set speed
 *
 *  @param view YLSliderBannerView
 *
 *  @return speed to banner slider
 */
-(CGFloat)speedForSlider:(YLSliderBannerView *)view
{
    if (view == self.messengerHeaderView && self.speedTextField.text.length!=0) {
        return [self.speedTextField.text integerValue];;
    }
    else return -1;
}

#pragma mark - reloadAction
/**
 *  reload button
 *
 *  @param sender call reload action
 */
- (IBAction)reloadAction:(id)sender
{
    [self.messengerHeaderView reload];
    /**
     *  set Text Field to empty and set label with string default
     */
    if (self.speedTextField.text.length!=0) {
         self.speedLabel.text = [NSString stringWithFormat:@"speed = %i,",(int)[self.speedTextField.text integerValue]];
    }
    else self.speedLabel.text = @"speed = 50,";
    if (self.distanceTextField.text.length!=0) {
        self.distanceLabel.text = [NSString stringWithFormat:@"distance = %i",(int)[self.distanceTextField.text integerValue]];
    }
    else self.distanceLabel.text = @"distance = 20";
}

#pragma mark - sendAction
/**
 *  send button
 *
 *  @param sender send parameter speed and distance to banner slider
 */
- (IBAction)sendAction:(id)sender
{
    /**
     *  check if Text Field is empty
     */
    if ((self.speedTextField.text.length == 0) && (self.distanceTextField.text.length==0)) {
    
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"no speed and no distance"
                                                        message:@"set speed or distance, please"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
        if ((self.speedTextField.text.length != 0)) {
            self.speedLabel.text = [NSString stringWithFormat:@"speed = %i,",(int)[self.speedTextField.text integerValue]];
        }
    if ((self.distanceTextField.text.length != 0)) {
        self.distanceLabel.text = [NSString stringWithFormat:@"distance = %i",(int)[self.distanceTextField.text integerValue]];
    }
    
    [self.messengerHeaderView reload];
    [self.stopButton setEnabled:YES];
    [self.reloadButton setEnabled:YES];
    self.speedTextField.text = @"";
    self.distanceTextField.text = @"";

}

#pragma mark - stopAction
/**
 *  stop button
 *
 *  @param sender stop the slider, set string default to label and set text field to empty 
 */
- (IBAction)stopAction:(id)sender
{
    [self.messengerHeaderView stop];
    self.speedLabel.text = @"speed = 0,";
    self.distanceLabel.text = @"distance = 0";
    self.speedTextField.text = @"";
    self.distanceTextField.text = @"";
}

@end
