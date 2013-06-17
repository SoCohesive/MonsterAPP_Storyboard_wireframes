//
//  OnboardingViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/12/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "OnboardingViewController.h"
#import "ScrollViewforOnBoarding.h"

@interface OnboardingViewController ()
{
    CATransform3D *theTransformer;
    CABasicAnimation *rotateAnimation; 
    
}

-(void) openDoorAnimation;

@end

@implementation OnboardingViewController

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
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
	// Do any additional setup after loading the view.
    self.navigationItem.hidesBackButton = YES;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tapGestureForDoor:(id)sender {
    
    [self openDoorAnimation];
    
    //Audio trigger below for door opening Monster_Door.wav
    SystemSoundID soundID;
    NSString *soundFile = [[NSBundle mainBundle]
						   pathForResource:@"Monster_Door" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
									 [NSURL fileURLWithPath:soundFile]
									 , &soundID);
    AudioServicesPlaySystemSound(soundID);
}

-(void) openDoorAnimation {
    
    // Make layer for door image and then change the anchorpoint so you can rotate the door on the y-axis 
    CALayer *layer = self.doorImage.layer;
    layer.anchorPoint = CGPointMake(0.0, 0.0);
    
    //Look over logic here. We are changing the size/ position of the layer to be half its original width. This is like the starting position before the animation begis
    CGPoint position = layer.position;
    CGSize size = layer.bounds.size;
    CGFloat posX= position.x - size.width / 2;
    CGFloat posY = position.y - size.height / 2;
    layer.position = CGPointMake(posX, posY);
    
        [UIView animateWithDuration:2.0f animations:^{
        CATransform3D rotateT = CATransform3DIdentity;
        rotateT.m34 = 1.0 /-300;
        rotateT= CATransform3DRotate(rotateT, -150.0f * M_PI/180.0f, 0, 1, 0);
        layer.transform = rotateT;
    }];
    
        
}

@end
