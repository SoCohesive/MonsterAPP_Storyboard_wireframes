//
//  MonsterEvolutionImageView.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Sonam Dhingra on 6/24/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "MonsterEvolutionImageView.h"

@implementation MonsterEvolutionImageView

{
    NSArray *tailFlickArray;
    NSArray *turtleWobble;
    NSArray *evolution3Array;
    NSArray *evolution4Array;

    SystemSoundID  soundID3;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark original Monster animation - no evolutions
-(void) showCheeksAnimation {
    
    self.alpha =0.0f;
    
    [UIView animateWithDuration:2
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         self.alpha = 1.0;
                         self.hidden= NO;
                         
                     } completion:^(BOOL finished) {
                         //
                     }];
    
}
-(void) animateEyesForBlinking {
    
    [UIView animateWithDuration:.4
                          delay:0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         //self.monsterRightEyeImage.hidden= NO;
                         self.hidden = NO;
                         
                         self.alpha = 1.0f;
                         //self.monsterRightEyeImage.alpha = 1.0f;
                         
                         
                         
                     } completion:^(BOOL finished) {
                                                
                         [UIView animateWithDuration:.4 delay:0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              
                                              self.alpha = 0.0f;
                                              //self.monsterRightEyeImage.alpha = 0.0f;
                                              
                                          } completion:^(BOOL finished) {
                                              
                                              
                                          }];
                         
                     }];
    
    NSString *soundFile3 = [[NSBundle mainBundle]
            pathForResource:@"Monster_Wink" ofType:@"wav"];
            
            AudioServicesCreateSystemSoundID((__bridge CFURLRef)
            [NSURL fileURLWithPath:soundFile3]
            , &soundID3);
            AudioServicesPlaySystemSound(soundID3);
    
    
}



#pragma mark Animations for Evolutions [1,2,3]
-(void)animationOne
{
    
    turtleWobble = [NSArray arrayWithObjects:
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-1.png"],
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-2.png"],
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-3.png"],
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-4.png"],
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-3.png"],
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-2.png"],
                    [UIImage imageNamed:@"turtling-ev1-for-TaskView-1.png"],nil];
    
    self.animationImages = turtleWobble;
    self.animationDuration = 1.0f;
    
    [self startAnimating];
}


-(void)tailFlickAnimate {
    
 tailFlickArray = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"turtling-ev2-for-TaskView-tailLow.png"],
                   [UIImage imageNamed:@"turtling-ev2-for-TaskView-tailMiddle.png"],
                   [UIImage imageNamed:@"turtling-ev2-for-TaskView-tailHigh.png"],
                   [UIImage imageNamed:@"turtling-ev2-for-TaskView-tailMiddle.png"],nil];

self.animationImages = tailFlickArray;
self.animationDuration = 1.0f;

[self startAnimating];

}

-(void) growLimbsEvo3 {
    
evolution3Array = [NSArray arrayWithObjects:
                   [UIImage imageNamed:@"turtling-ev3-for-TaskView-1.png"],
                   [UIImage imageNamed:@"turtling-ev3-for-TaskView-2.png"],
                   [UIImage imageNamed:@"turtling-ev3-for-TaskView-3.png"],
                   [UIImage imageNamed:@"turtling-ev3-for-TaskView-4.png"],
                   [UIImage imageNamed:@"turtling-ev3-for-TaskView-3.png"],
                   [UIImage imageNamed:@"turtling-ev3-for-TaskView-2.png"],nil];

self.animationImages = evolution3Array;
self.animationDuration = 1.0f;

[self startAnimating];
    
}

-(void) growWingsEvo4 {
    
    evolution3Array = [NSArray arrayWithObjects:
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-1.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-2.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-3.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-4.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-5.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-6.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-7.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-6.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-5.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-4.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-3.png"],
                       [UIImage imageNamed:@"turtling-ev4-for-TaskView-2.png"],nil];
    
    self.animationImages = evolution3Array;
    self.animationDuration = 1.0f;
    
    [self startAnimating];
    
}
@end
