//
//  EvolutionViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/12/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "EvolutionViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface EvolutionViewController ()
{
    NSArray *turtleWobble;
    NSArray *tailFlickArray;
}
@end

@implementation EvolutionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //[self.shineForRotation rotateShine];
    [super viewDidLoad];

    self.evolutionDescriptionLabel.text = self.evolutionForImages.evolutionDescription;
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.evolutionDescriptionLabel.font.pointSize];
    self.evolutionDescriptionLabel.font = lunchBoxBold;
    
    NSLog(@"%@", self.evolutionForImages.evolutionNumber);
    
    if ([self.evolutionForImages.evolutionNumber intValue]== 1) {
        
        [self performSelector:@selector(evol1Animate) withObject:nil afterDelay:.5f];

    } else {

        [self performSelector:@selector(tailFlickAnimate) withObject:nil afterDelay:.5f];
    }

	// Do any additional setup after loading the view.
    
    SystemSoundID soundID;
    NSString *soundFile = [[NSBundle mainBundle]
						   pathForResource:@"Monster_Step" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
									 [NSURL fileURLWithPath:soundFile]
									 , &soundID);
    AudioServicesPlaySystemSound(soundID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)evol1Animate
{
    
    turtleWobble = [NSArray arrayWithObjects:
                      [UIImage imageNamed:@"turtling-ev1-for-TaskView-1.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-2.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-3.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-4.png"],[UIImage imageNamed:@"turtling-ev1-for-TaskView-3.png"], [UIImage imageNamed:@"turtling-ev1-for-TaskView-2.png"],  [UIImage imageNamed:@"turtling-ev1-for-TaskView-1.png"],nil];
    
    self.wobbleView.animationImages = turtleWobble;
    self.wobbleView.animationDuration = 1.0f;
    //self.stillStickFigureImageView.alpha = 0;
    
    [self.wobbleView startAnimating];
}

-(void)tailFlickAnimate
{
    
    tailFlickArray = [NSArray arrayWithObjects:
                             [UIImage imageNamed:@"turtling-ev2-for-TaskView-tailLow.png"],[UIImage imageNamed:@"turtling-ev2-for-TaskView-tailMiddle.png"],[UIImage imageNamed:@"turtling-ev2-for-TaskView-tailHigh.png"],[UIImage imageNamed:@"turtling-ev2-for-TaskView-tailMiddle.png"],nil];
    
    self.faceView.animationImages = tailFlickArray;
    self.faceView.animationDuration = 1.0f;
    //self.stillStickFigureImageView.alpha = 0;
    
    [self.faceView startAnimating];

}
@end
