//
//  EvolutionViewController.h
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/12/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SparkleImageView.h"
#import "Evolution.h"

@interface EvolutionViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *evolutionDescriptionLabel;
@property (strong, nonatomic) IBOutlet SparkleImageView *shineForRotation;
@property (strong, nonatomic) IBOutlet UIImageView *faceView;
@property (strong, nonatomic) IBOutlet UIImageView *wobbleView;
@property (strong, nonatomic) IBOutlet UIImageView *evolution3;
@property (strong, nonatomic) Evolution *evolutionForImages;
@end
