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

@interface OnboardingViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *doorImage;
- (IBAction)tapGestureForDoor:(id)sender;


@end
