//
//  NewEggViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SparkleImageView.h"
#import "User.h"
#import <AudioToolbox/AudioToolbox.h>

@interface NewEggViewController : UIViewController

@property (strong, nonatomic) NSString *projectTypeName;
@property (strong, nonatomic) IBOutlet UILabel *tapInstructionLabel;
@property (weak, nonatomic) IBOutlet SparkleImageView *sparkleImage;
@property (strong, nonatomic) NSString *monsterType;
@end
