//
//  EvolutionViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/12/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "EvolutionViewController.h"

@interface EvolutionViewController ()

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
    self.evolutionDescriptionLabel.font = lunchBoxBold;

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
