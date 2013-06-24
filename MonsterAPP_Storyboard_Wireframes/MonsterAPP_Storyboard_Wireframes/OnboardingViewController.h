//
//  OnboardingViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/12/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import <AudioToolbox/AudioToolbox.h>

@interface OnboardingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *doorImage;
@property (weak, nonatomic) IBOutlet UIImageView *monsterImage;
@property (weak, nonatomic) IBOutlet UIImageView *monsterPawImage;

@property (weak, nonatomic) IBOutlet UIImageView *getStartedLabel;
@property (weak, nonatomic) IBOutlet UIButton *noteImageForButton;

- (IBAction)getStartedButton:(id)sender;

@end
