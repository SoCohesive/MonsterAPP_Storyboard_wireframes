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
   // NSArray *turtleWobble;
    //NSArray *tailFlickArray;
   // NSArray *evolution3Array;
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
    
    //implement evolution logic
    NSLog(@"%@", self.evolutionForImages.currentEvolution);
    
    if ([self.evolutionForImages.evolutionNumber intValue] == 1) {
        
        [self performSelector:@selector(wobbleHeadEvo1) withObject:nil afterDelay:.5f];

    } else if ([self.evolutionForImages.evolutionNumber intValue]== 2) {
        
        [self performSelector:@selector(flickTailEvo2) withObject:nil afterDelay:.5f];
    
    } else if([self.evolutionForImages.evolutionNumber intValue]== 3)
        {
            
        [self performSelector:@selector(addLimbsEvo3) withObject:nil afterDelay:.5f];
        
        } else {
        
            [self performSelector:@selector(addWingsEvo4) withObject:nil afterDelay:.5f];
        }

	// Do any additional setup after loading the view.
    
    SystemSoundID soundID;
    NSString *soundFile = [[NSBundle mainBundle]
						   pathForResource:@"Monster_Step" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
									 [NSURL fileURLWithPath:soundFile]
									 , &soundID);
    AudioServicesPlaySystemSound(soundID);
    
    // dismiss view after time interval
    [self performSelector:@selector(goBackToTaskView) withObject:nil afterDelay:2.8];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)wobbleHeadEvo1 {
   
    [self.monsterImagesForAnimation animationOne];
   
}

-(void)flickTailEvo2
{
  
    [self.monsterImagesForAnimation tailFlickAnimate];

}

-(void)addLimbsEvo3 
{
    
    [self.monsterImagesForAnimation growLimbsEvo3];

}

-(void)addWingsEvo4
{
    
    [self.monsterImagesForAnimation growWingsEvo4];
    
}

- (void)goBackToTaskView {
    
    [self dismissViewControllerAnimated:YES completion:^{

    
    }];
}



@end
