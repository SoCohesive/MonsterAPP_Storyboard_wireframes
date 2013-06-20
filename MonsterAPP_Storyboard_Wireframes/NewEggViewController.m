//
//  NewEggViewController.m
//  MonsterAPP_Storyboard_Wireframes
//
//  Created by Erin Hochstatter on 6/10/13.
//  Copyright (c) 2013 Sonam Dhingra. All rights reserved.
//

#import "NewEggViewController.h"
#import "ProjectNameVC.h"

@interface NewEggViewController ()
{
    NSArray *congratPhrases;
    NSString *projectPhrase;
}
@property (strong, nonatomic) IBOutlet UILabel *achievementText;
@property (strong, nonatomic) IBOutlet UILabel *hintLabel;
@property (strong, nonatomic) IBOutlet UILabel *congratsLabel;


-(void)chooseAchievementMessage;
-(void)chooseCongrat;
-(void)rephraseProjectType;

@end

@implementation NewEggViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{    //perfect world, we would have a way to randomly select our monster from the roster.
    [self.sparkleImage setBackgroundColor:[UIColor blueColor]];
    
    [self.sparkleImage rotateShine];
    
    [super viewDidLoad];
    
    //eventually this string will come from an array of monster names.
    self.monsterType = @"turtling";

    
    [self chooseCongrat];
    [self chooseAchievementMessage];
    UIFont *lunchBoxBold = [UIFont fontWithName:@"LunchBox-Light" size:self.congratsLabel.font.pointSize];
    self.congratsLabel.font = lunchBoxBold;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
            
    // Audio triggers below, with Monster_Shimmer.wav sound
    
    SystemSoundID soundID2;
    NSString *soundFile2 = [[NSBundle mainBundle]
                            pathForResource:@"Monster_Shimmer" ofType:@"wav"];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)
									 [NSURL fileURLWithPath:soundFile2]
									 , &soundID2);
    AudioServicesPlaySystemSound(soundID2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)chooseCongrat
{
    congratPhrases = [NSMutableArray arrayWithObjects: @"Congrats!", @"Awesome!", @"Way to Go!", @"You're a Rockstar!", @"Yay!", @"Hooray!", nil];

    int messageIndexPath = arc4random()%(congratPhrases.count-1);
    NSString *congratText = congratPhrases[messageIndexPath];
    
    self.congratsLabel.text = congratText;
}

-(void)rephraseProjectType
{
    
    if ([self.projectTypeName isEqual:@"Study for a Test"]) {
        projectPhrase = @"test preparation";
        
    } else if ([self.projectTypeName isEqual:@"Write a Book Report"]){
        projectPhrase = @"book report";
        
         }    else {
             projectPhrase = @"science fair project";
         }
    
}

-(void)chooseAchievementMessage
{
     [self rephraseProjectType];
       
        NSString *achievementString = [NSString stringWithFormat:@"Starting your %@ earned you a new %@ egg!",projectPhrase, self.monsterType];
        self.achievementText.text = achievementString;
        self.hintLabel.text = @"hint: you might want to start thinking of names";

}


#pragma
#pragma mark Segue to Naming Project


- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    
    //CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    [self performSegueWithIdentifier:@"segueToProjectName" sender:self];

}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    ((ProjectNameVC*)(segue.destinationViewController)).projectTypeForName = self.projectTypeName;
    ((ProjectNameVC*)(segue.destinationViewController)).monsterKind = self.monsterType;
    ((ProjectNameVC*)(segue.destinationViewController)).projNameUser = self.eggUser;
    NSLog(@"ProjectType sent to Name View -->%@",((ProjectNameVC*)(segue.destinationViewController)).projectTypeForName);
    
}

@end
